using System;
using System.Collections.Generic;
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
using TafeMoodle.Model;

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for LoginPage.xaml
    /// </summary>
    public partial class LoginPage : Page
    {
        //Your login is Julie.Lam1003@tafe.com
        DataAccessLayer dataAccess = new DataAccessLayer();

        string username;
        string password;

        public LoginPage()
        {
            InitializeComponent();
        }

        private void loginBtn_Click(object sender, RoutedEventArgs e)
        {
            //1. Retrieves username and password inputs  
            username = usernameInput.Text;
            password = passwordInput.Password;

            //2. Textfield validation 
            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                MessageBox.Show("Please complete all fields by entering a username followed by your password");
            }
            else
            {
                //If login details are correct, navigate to landing page. Otherwise, display error message 
                if (dataAccess.isCorrectLogin(username, password, out int userID, out string userType))
                {
                    //If student, do this
                    if (userType == "Student")
                    {
                        NavigationService.Navigate(new LandingPageStud(userID));
                    }
                    else
                    {
                        NavigationService.Navigate(new LandingPage(userID));
                    }

                }
                else
                {
                    MessageBox.Show("Login details incorrect. Either try again or register for an account instead!");
                }
            }
        }

        private void registerBtn_Click(object sender, RoutedEventArgs e)
        {
            //Navigates to RegisterPage
            NavigationService.Navigate(new RegisterPage());
        }
    }
}
