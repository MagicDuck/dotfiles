#!/bin/bash
session=`loginctl session-status | head -n 1 | awk '{print $1}'`
loginctl terminate-session $session
