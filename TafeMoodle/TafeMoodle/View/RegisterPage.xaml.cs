using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using TafeMoodle.Data_Access_Layer;

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for RegisterPage.xaml
    /// </summary>
    public partial class RegisterPage : Page
    {
        string firstName, lastName, mobNum, sex, streetName, suburb, state, password, secPassword, userType;
        int unitNum, postcode;
        bool houseNumIsNum, postcodeIsNum;

        DataAccessLayer dataAccess = new DataAccessLayer();

        public RegisterPage()
        {
            InitializeComponent();
        }

        private void canxBtn_Click(object sender, RoutedEventArgs e)
        {
            //Returns to LoginPage()
            NavigationService.GoBack();
        }

        private void regBtn_Click(object sender, RoutedEventArgs e)
        {
            //Complete register func

            // I) Text field validations 
            firstName = firstNameInput.Text;
            lastName = lastNameInput.Text;
            mobNum = mobInput.Text;
            sex = sexInput.Text;
            houseNumIsNum = Int32.TryParse(houseNumInput.Text, out unitNum);
            streetName = streetNameInput.Text;
            suburb = suburbInput.Text;
            state = stateInput.Text;
            postcodeIsNum = Int32.TryParse(postcodeInput.Text, out postcode);
            password = passwordInput.Text;
            secPassword = passwordSecondInput.Text;
            userType = userTypeInput.Text;


            if (String.IsNullOrEmpty(firstName) || String.IsNullOrWhiteSpace(firstName) ||
                String.IsNullOrEmpty(lastName) || String.IsNullOrWhiteSpace(lastName) ||
                String.IsNullOrEmpty(mobNum) || String.IsNullOrWhiteSpace(mobNum) ||
                houseNumIsNum == false ||
                String.IsNullOrEmpty(streetName) || String.IsNullOrWhiteSpace(streetName) ||
                String.IsNullOrEmpty(suburb) || String.IsNullOrWhiteSpace(streetName) ||
                String.IsNullOrEmpty(state) || String.IsNullOrWhiteSpace(state) ||
                postcodeIsNum == false ||
                String.IsNullOrEmpty(password) || String.IsNullOrWhiteSpace(password) ||
                String.IsNullOrEmpty(secPassword) || String.IsNullOrWhiteSpace(secPassword)
                )
            {
                MessageBox.Show("Please complete ALL fields");
            }

            else
            {
                // II) Check if Student or Teacher
                string uniqueUsername;

                if (userType == "Student")
                {
                    //dataaccess method to update student table
                    uniqueUsername = dataAccess.addStudentToDB(firstName, lastName, mobNum, sex, password, unitNum, streetName, suburb, state, postcode);

                    MessageBox.Show("Congratulations, You've successfully registered as a Student! Your unique username is " + uniqueUsername);
                }
                else if (userType == "Teacher")
                {
                    //dataaccess method to update teacher table
                    uniqueUsername = dataAccess.addTeacherToDB(firstName, lastName, mobNum, sex, password, unitNum, streetName, suburb, state, postcode);

                    MessageBox.Show("Congratulations, You've successfully registered as a Teacher! Your unique username is " + uniqueUsername);
                }

                NavigationService.GoBack();

            }


        }
    }
}
