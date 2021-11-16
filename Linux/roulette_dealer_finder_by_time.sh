#!/bin/bash
grep $1 $2_Dealer_schedule | awk -F" " '{print $5, $6}'
