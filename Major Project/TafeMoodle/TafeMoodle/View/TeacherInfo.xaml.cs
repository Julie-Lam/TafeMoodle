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
    /// Interaction logic for TeacherInfo.xaml
    /// </summary>
    public partial class TeacherInfo : Page
    {

        DataAccessLayer dataAccess = new DataAccessLayer();

        int thisTeachID;

        public TeacherInfo(int teacherID)
        {
            InitializeComponent();

            thisTeachID = teacherID;

            //Populate this screen
            Teacher aTeacher = dataAccess.getTeachInfoByID(thisTeachID);

            this.DataContext = aTeacher;

            //Populate sex combobox
            switch (aTeacher.sex)
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


            //Populate coursesLB
            foreach (Course course in aTeacher.courseList)
            {
                coursesLB.Items.Add(course.courseID + ": " + course.courseName);
            }

            //Populate address
            addressIDTxt.Text = aTeacher.address.addressID.ToString();
            houseNumTxt.Text = aTeacher.address.houseNum.ToString();
            streetNameTxt.Text = aTeacher.address.streetName;
            suburbTxt.Text = aTeacher.address.suburb;

            //Populate state Combobox
            switch (aTeacher.address.state)
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
            postcodeTxt.Text = aTeacher.address.postcode.ToString();
        }

        private void goBackBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }

        private void deleteBtn_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Once you delete this record, it cannot be recovered", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                dataAccess.deleteTeachByID(thisTeachID);

                App.MainPage.activeScreenFrame.Content = new TeacherSearch();
            }
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

                    Teacher updatedTeach = new Teacher()
                    {
                        userID = thisTeachID,
                        firstName = firstNameTxt.Text,
                        lastName = lastNameTxt.Text,
                        sex = sexCmb.Text,
                        address = address,
                        mobNum = mobNumTxt.Text,
                    };

                    //save to db 
                    dataAccess.updateTeach(address, updatedTeach);
                    App.MainPage.activeScreenFrame.Content = new TeacherSearch();
                }
            }
            else
            {
                MessageBox.Show("Please enter NUMBERS ONLY in Mobile Number and Postcode fields");
            }
        }
    }
}
