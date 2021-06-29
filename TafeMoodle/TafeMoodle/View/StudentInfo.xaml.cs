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
using System.Linq;

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for StudentInfo.xaml
    /// </summary>
    public partial class StudentInfo : Page
    {

        DataAccessLayer dataAccess = new DataAccessLayer();

        int thisStudID;

        public StudentInfo(int studID)
        {

            InitializeComponent();

            thisStudID = studID;

            //Populate this screen
            Student aStudent = dataAccess.getStudInfoByID(thisStudID);

            this.DataContext = aStudent;

            //Populate sex combobox
            switch (aStudent.sex)
            {
                case "Male":
                    sexCmb.SelectedIndex = 0;
                    break;
                case "Female":
                    sexCmb.SelectedIndex = 1;
                    break;
                default:
                    sexCmb.SelectedIndex = -1;
                    break;
            }


            //Populate enrolledCoursesLB
            foreach (Course course in aStudent.enrolledCourseList)
            {
                enrolledCoursesLB.Items.Add(course.courseID + ": " + course.courseName);
            }

            //Populate address
            addressIDTxt.Text = aStudent.address.addressID.ToString();
            houseNumTxt.Text = aStudent.address.houseNum.ToString();
            streetNameTxt.Text = aStudent.address.streetName;
            suburbTxt.Text = aStudent.address.suburb;

            //Populate state Combobox
            switch (aStudent.address.state)
            {
                case "NSW":
                    stateCB.SelectedIndex = 0;
                    break;

                case "VIC":
                    stateCB.SelectedIndex = 1;
                    break;
                case "QLD":
                    stateCB.SelectedIndex = 2;
                    break;
                case "SA":
                    stateCB.SelectedIndex = 3;
                    break;
                case "TAS":
                    stateCB.SelectedIndex = 4;
                    break;
                case "WA":
                    stateCB.SelectedIndex = 5;
                    break;
                default:
                    stateCB.SelectedIndex = -1;
                    break;
            }

            //Populate postcode
            postcodeTxt.Text = aStudent.address.postcode.ToString();
        }

        private void goBackBtn_Click(object sender, RoutedEventArgs e)
        {
            //App.MainPage.activeScreenFrame.Content = new StudentSearch();
            NavigationService.GoBack();
        }

        private void updateBtn_Click(object sender, RoutedEventArgs e)
        {
            int mobNumInt;
            int postcodeInt;
            int houseNumInt;

            //Validate mob num and postcode inputs are numbers 
            if (int.TryParse(mobNumTxt.Text, out mobNumInt) && int.TryParse(postcodeTxt.Text, out postcodeInt) && int.TryParse(houseNumTxt.Text, out houseNumInt))
            {
                //Validate whether fields are null, empty or whitespace 
                if (string.IsNullOrEmpty(firstNameTxt.Text) || string.IsNullOrWhiteSpace(firstNameTxt.Text) ||
                    string.IsNullOrEmpty(lastNameTxt.Text) || string.IsNullOrWhiteSpace(lastNameTxt.Text) ||
                    string.IsNullOrEmpty(houseNumTxt.Text) || string.IsNullOrWhiteSpace(houseNumTxt.Text) ||
                    string.IsNullOrEmpty(streetNameTxt.Text) || string.IsNullOrWhiteSpace(streetNameTxt.Text) ||
                    string.IsNullOrEmpty(suburbTxt.Text) || string.IsNullOrWhiteSpace(suburbTxt.Text) ||
                    string.IsNullOrEmpty(postcodeTxt.Text) || string.IsNullOrWhiteSpace(postcodeTxt.Text) ||
                    string.IsNullOrEmpty(mobNumTxt.Text) || string.IsNullOrWhiteSpace(mobNumTxt.Text))
                {
                    MessageBox.Show("Cannot save changes with empty fields");
                }


                else if (MessageBox.Show("Once you save this record, it cannot be reverted", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
                {
                    Address address = new Address()
                    {
                        addressID = int.Parse(addressIDTxt.Text),
                        houseNum = houseNumInt,
                        streetName = streetNameTxt.Text,
                        suburb = suburbTxt.Text,
                        state = stateCB.Text,
                        postcode = postcodeInt
                    };

                    Student updatedStud = new Student()
                    {
                        userID = thisStudID,
                        firstName = firstNameTxt.Text,
                        lastName = lastNameTxt.Text,
                        sex = sexCmb.Text,
                        address = address,
                        mobNum = mobNumTxt.Text,
                    };

                    //save to db 
                    dataAccess.updateStud(address, updatedStud);
                    App.MainPage.activeScreenFrame.Content = new StudentSearch();
                }
            }
            else
            {
                MessageBox.Show("Please enter NUMBERS ONLY in Mobile Number and Postcode fields");
            }

        }

        private void deleteBtn_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Once you delete this record, it cannot be recovered", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                dataAccess.deleteStudByID(thisStudID);

                App.MainPage.activeScreenFrame.Content = new StudentSearch();
            }
        }
    }
}
