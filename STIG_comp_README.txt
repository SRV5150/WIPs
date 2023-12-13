*******************************************************README******************************************************

Project Title: STIG_comp

Description: This is a BASH script written to automate a few of the STIG compliance checks for Ubuntu 2020.04.6.
It takes three CAT I STIGs and two CAT II STIGs and automates the process of running the compliance checks and even fixing the issues if the user wishes. There are a lot of STIGs out there, and some of them are beyond my scope to automate, as the fixes can be quite complex and dynamic. This really is just an example of what I accomplished in a recent BASH scripting class in college.
The script also creates a file named STIG_comp_2023.txt and sends the results from the checks there.

I could possibly see myself going into the compliance domain of cybersecurity and if such an opportunity arises, I might find myself back to adding more features to this script.

*Note - most updated versions of Ubuntu 2020.04.6 won't show any results for these save the last check for the AIDE (Advanced Intrusion Detection Environment) package. 

Installation: All you have to do is copy the script to a .sh file or copy / paste it in a directory of your choosing and run it from there.

Use: Just like with any BASH script you create with a standard user account in a machine, you'll need to use the "$ su STIG_comp.sh" command to run it. You could also use "$ chmod +x STIG_comp" to add the permission to use it for any account.

Resources: I ran a VM with VMware Workstation Player from vmware.com and an Ubuntu 2020.04.6 ISO directly from ubuntu.com. I used 3 cores and 8 GB of RAM on a system with 12 cores and 32 GB of RAM available.  If I couldn't figure out something in the code, I just kept playing with it until I hit upon the right combination. I learned some basic programming in Python, but sometimes the syntax just trips me up. I also got some help from stackexchange.com and freecodecamp.org.

Now for the legal stuff: In short, know what the code you're running does. That's not my responsibility. This was a school project, and I am not a professional developer. This means you're using this at your own risk as there is no warranty expressed or implied. 

contact info: SRV5150JS@outlook.com