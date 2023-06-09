#!/bin/bash

# Define colors using ANSI escape codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if the llm_insights.py script exists in the root directory
if [ ! -f "llm_insights.py" ]; then
    echo -e "${RED}Error: llm_insights.py not found. Ensure it is in the root directory of your git repository.${NC}"
    exit 1
fi

# Run the llm_insights.py script
echo -e "${CYAN}Running LLM Insights...${NC}"
python llm_insights.py

# Check the exit code of the script
exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo -e "${RED}LLM Insights encountered an error. Commit aborted.${NC}"
    exit 1
fi

# Ask the user if they want to proceed with the commit
while true; do
    read -p "$(echo -e ${YELLOW}LLM Insights completed successfully. Do you want to proceed with the commit? [y/n]: ${NC})" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo -e "${RED}Commit aborted by user.${NC}"; exit 1;;
        * ) echo "Please answer y (yes) or n (no).";;
    esac
done

# If the user chooses to proceed, continue with the commit
echo -e "${GREEN}Proceeding with the commit.${NC}"
exit 0
