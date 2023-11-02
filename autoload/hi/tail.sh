#!/bin/bash
################################################################################# 
# Script Name: hi/tail.sh
# Description: update local file with rsync from remote address.
#   Perform diff between local and updated file, preserve only the changes betwenn both files.
#   Launch filter command (ag or grep normally) into the updated file.
#   Result can be found on files: "LOCALFILE.main" and "LOCALFILE.filt".
# 
# Copyright:   (C) 2017-2021 Javier Puigdevall
#   The VIM LICENSE applies to this script; see ':help copyright'.
#
# Maintainer:  Javier Puigdevall <javierpuigdevall@gmail.com>
# Contributors:
#
# Dependencies:
#   rsync
#   diff
# 
# Script arguments:
# ./tail.sh REMOTE_FILE_PATH LOCAL_FILE_PATH 
# Examples: 
#  ./tail.sh USER@IP:/PATH/FILE LOCALFILE
#  ./tail.sh "" LOCALFILE

# Script arguments expected on file:
# This argument is send using a file to prevent problems with the syntax.
# Expected file name: LOCAL_FILE_PATH.cmd conaining the ag or grep commands for each filter window.
# Example:
#  cat LOCALFILE.cmd 
#     ag -s --nofilename "PATTERN"
#  cat LOCALFILE.cmd 
#     ag -s --nofilename "PATTERN"
#     ag -s --nofilename "PATTERN" | ag -v "PATTER1|PATTERN2"
#  cat LOCALFILE.cmd 
#     egrep -i "PATTERN1|PATTERN2"
#     egrep -i "PATTERN3|PATTERN4" | egrep -i "PATTERN5"
# 
################################################################################# 

if [[ ${#} -lt 2 ]]; then
    echo "ERROR. Missing arguments."
    echo "$0 REMOTE_FILE LOCAL_FILE FILT_CMD"
    return 1
fi

readonly REMOTE_FILE="${1}"
readonly LOCAL_FILE="${2}"

if [[ ! -f ${LOCAL_FILE} ]]; then
    echo "ERROR. Local file $LOCAL_FILE not found"
    exit 1
fi

readonly MAIN_FILE="${LOCAL_FILE}.main"
readonly FILT_FILE="${LOCAL_FILE}.filt"
readonly CMD_FILE="${LOCAL_FILE}.cmd"


# Make a copy
cp ${LOCAL_FILE} ${LOCAL_FILE_UPDATED}

if [[ -f "${REMOTE_FILE}" ]]; then
    readonly LOCAL_FILE_UPDATED="${REMOTE_FILE}" 
    echo "Local file: ${LOCAL_FILE_UPDATED}"
else
    # Update local file with rsync
    readonly LOCAL_FILE_UPDATED="${LOCAL_FILE}.updated"

    if [[ "${REMOTE_FILE}" != "" ]]; then
        echo ""
        echo "Rsync: ${REMOTE_FILE}"
        time rsync -P ${REMOTE_FILE} ${LOCAL_FILE_UPDATED}

        if [[ $? -ne 0 ]]; then
            echo "ERROR. Rsync failed."
            exit 2
        fi
        echo ""
    fi
fi


# Get changes
echo ""
echo "Diff:"
time diff --changed-group-format='%>' --unchanged-group-format='' ${LOCAL_FILE} ${LOCAL_FILE_UPDATED} > ${MAIN_FILE}

if [[ $? -eq 0 ]]; then
    # Both files are the same.
    mv ${LOCAL_FILE} ${MAIN_FILE}
    echo ""
    echo "Remote and local files do not differ."
    exit 1
else
    LEN="`wc -l ${MAIN_FILE}`"
    echo ""
    echo "Remote and local files differ lines: ${LEN}."
fi


# Get changes for every Filter window
if [[ "${CMD_FILE}" ]] && [[ -f "${CMD_FILE}" ]]; then
    let N=1
    while read LINE; do
        FILT_CMD="`echo "${LINE}" | sed 's///g'`"

        if [[ "${FILT_CMD}" ]]; then
            CMD="time ${FILT_CMD} ${MAIN_FILE} > ${FILT_FILE}${N}"
            echo ""
            echo "Filter${N}: ${CMD}"
            eval "${CMD}"

            LEN="`wc -l ${FILT_FILE}${N}`"
            echo ""
            echo "Filter file${N} lines: ${LEN}."
            let N+=1
        fi
    done < ${CMD_FILE}
fi

exit 0
