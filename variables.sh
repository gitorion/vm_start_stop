#!/usr/bin/env bash

# these are variables associated with vm_start_stop script 

r=yes
AVAILABLE_VMS_NUM=$(find ~ -type f -name "*.vmx" 2>/dev/null | wc -l | tr -d ' ')
AVAILABLE_VMS=$(find ~ -type f -name "*.vmx" 2>/dev/null)

# Specify ASCII colours

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Specify colour characters

GP="${GREEN}[+]${NC}"
RN="${RED}[-]${NC}"
YE="${YELLOW}[!]${NC}"
BA="${BLUE}[*]${NC}"

# sed 's/$/"/' | sed 's/^/"/' *note: this command adds quotes to the start and end of a string output