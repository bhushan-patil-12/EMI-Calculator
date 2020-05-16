#!/bin/bash
# A menu driven shell script for EMI calculator

#EMI function--
EMI_FUNCTION()
{
clear
echo -n "Enter name(use underscore instead of space): "
read name
echo -n "Enter principal amount (in rupees) :Rs."
read principal
echo -n "Enter rate (in %): "
read rate
echo -n "Enter time (in months): "
read time

echo "NAME-$name"   $(date) >>"emi_log.txt"
echo "PRINCIPAL AMOUNT-Rs.$principal   RATE-$rate %  TIME-$time months">>"emi_log.txt"
rate=$(bc -l<<< "$rate/(12*100)")
time=$(bc -l<<< "$time")
rate_new=$(bc -l<<< "($rate+1)^$time")
emi=$(bc -l <<< "($principal*$rate*$rate_new)/($rate_new-1)")
total_amount=$(bc -l <<< "($emi*$time)")
total_interest=$(bc -l <<< "($total_amount-$principal)")
echo ""
emi=$(printf "%.0f" $emi)
total_amount=$(printf "%.0f" $total_amount)
total_interest=$(printf "%.0f" $total_interest)
echo "EMI : Rs."$emi;
echo "Total interest due : Rs."$total_interest
echo "Total Amount to be Paid : Rs."$total_amount

echo "EMI-Rs.$emi   TOTAL INTEREST DUE-Rs.$total_interest   TOTAL AMOUNT TO BE PAID-Rs.$total_amount">>"emi_log.txt"
echo "">>"emi_log.txt"
echo "[PRESS ENTER FOR MENU...]"
read enterKey
}

#records function--
records_function()
{
while :
do
 clear
 echo "$(tput setaf 6)"
 echo "---MENU---"
 echo "1. Search by name"
 echo "2. display all records"
 echo "3. exit"
 echo -n "Please enter option [1 - 3] : "
 read opt
 case $opt in
  1)clear ;
    echo -n "Enter name :";
	read name;
    grep -A 3 "$name" emi_log.txt ;
    echo "[PRESS ENTER FOR MENU...]";
	read enterKey ;;
  2)clear ;
    cat emi_log.txt;
	echo "[PRESS ENTER FOR MENU...]";
	read enterKey ;;
  3)break;;
  *) echo "$opt is an invaild option. Please select option between 1-4 only";
     echo "Press [enter] key . . .";
     read enterKey;;
esac
done
}

#Help function--
help_function()
{
clear
echo "$(tput setaf 2)"
echo "-----ABOUT EMI-----"
echo "What is EMI?"
echo "An EMI or Equated Monthly Installment is defined by Investopedia as A fixed payment "
echo "amount made by a borrower to a lender at a specified date each calendar month."
echo "Equated monthly installments are used to pay off both interest and principal each month, "
echo "so that over a specified number of years, the loan is fully paid off along with interest."
echo ""
echo "How to calculate EMI?"
echo "EMI = [P x R x (1+R)^N]/[(1+R)^N-1] "
echo "where P stands for the loan amount or principal" 
echo "R is the interest rate per month "
echo "N is the number of monthly instalments."
echo ""
echo "[PRESS ENTER FOR MENU...]"
read enterKey
}

#menu--
while :
do
 clear
 echo "$(tput setaf 3)"
 echo "--- MAIN-MENU ---"
 echo "1. EMI Calculator"
 echo "2. Previous Records"
 echo "3. Help"
 echo "4. Exit"
 echo -n "Please enter option [1 - 4]: "
 read opt
 case $opt in
  1) echo "--EMI CALCULATOR--";
  EMI_FUNCTION ;;
  2) echo "--Records--";
  records_function ;;
  3) help_function ;;
  4) exit 1;;
  *) echo "$opt is an invaild option. Please select option between 1-4 only";
     echo "Press [enter] key to continue. . .";
     read enterKey;;
esac
done