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
using TafeMoodle.Model;
using TafeMoodle.Data_Access_Layer;

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for CourseAdd.xaml
    /// </summary>
    public partial class CourseAdd : Page
    {
        DataAccessLayer dataAccess = new DataAccessLayer();

        public CourseAdd()
        {
            InitializeComponent();

            populateStudID(idTxt);

            populateLocationsUI(locationStack);

            populateSemsUI(semesterStack);

            populateSubsUI(subjectStack);
        }


        public void populateStudID(TextBox idTextBox)
        {
            int nextStudID = dataAccess.getLatestCourseID();

            idTextBox.Text = nextStudID.ToString();
        }

        public void populateLocationsUI(StackPanel locStackPanel)
        {

            //Grab from db all distinct loc
            List<Location> allAvailLocs = dataAccess.getAllCourseLocations();

            foreach (var loc in allAvailLocs)
            {
                CheckBox cb = new CheckBox();
                cb.Content = loc.locationID + ": " + loc.address;
                locStackPanel.Children.Add(cb);
            }

        }

        public void populateSemsUI(StackPanel semStackPanel)
        {
            //Grab from db all distinct sem 
            List<Semester> allAvailSems = dataAccess.getAllSemesters();

            foreach (var sem in allAvailSems)
            {
                CheckBox cb = new CheckBox();
                cb.Content = sem.semID + ": " + sem.semStartDate.ToShortDateString() + "-" + sem.semFinishDate.ToShortDateString();
                semStackPanel.Children.Add(cb);
            }

        }

        public void populateSubsUI(StackPanel substackPanel)
        {
            List<Subject> allAvailSubs = dataAccess.getAllSubs();

            foreach (var sub in allAvailSubs)
            {
                CheckBox cb = new CheckBox();
                cb.Content = sub.subID + ": " + sub.subName;
                substackPanel.Children.Add(cb);
            }

        }

        private bool isValidateCBField(StackPanel stackPanel)
        {


            bool CBSelected = false;

            foreach (CheckBox item in stackPanel.Children)
            {
                if (item.IsChecked == true)
                {
                    CBSelected = true;
                }
            }

            return CBSelected;
        }

        public List<int> getSelectedCBItemIDs(StackPanel stackPanel)
        {
            List<int> selectedItemIDs = new List<int>();

            foreach (CheckBox item in stackPanel.Children)
            {
                if (item.IsChecked == true)
                {
                    string[] selectedItem = item.Content.ToString().Split(':');

                    selectedItemIDs.Add(int.Parse(selectedItem[0]));
                }
            }

            return selectedItemIDs;
        }



        private void CancelBtn_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Any information you have added so far will not be saved", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                NavigationService.GoBack();
            }
        }

        private void saveBtn_Click(object sender, RoutedEventArgs e)
        {

            int duration;
            double fee;

            bool durationIsInt = int.TryParse(durationTxt.Text, out duration);
            bool feeIsDouble = double.TryParse(feeTxt.Text, out fee);

            if (isValidateCBField(locationStack) && isValidateCBField(semesterStack) && isValidateCBField(subjectStack))
            {
                //Get all checked CB IDs in stack 
                List<int> selSemIDs = getSelectedCBItemIDs(semesterStack);
                List<int> selLocIDs = getSelectedCBItemIDs(locationStack);
                List<int> selSubIDs = getSelectedCBItemIDs(subjectStack);


                if (durationIsInt && feeIsDouble)
                {
                    //get all inputs and save 
                    Course newCourse = new Course()
                    {
                        courseName = courseNameTxt.Text,
                        durationWks = duration,
                        fee = fee,
                        studyMode = studyModeCB.Text
                    };

                    dataAccess.addCourse(newCourse, selSemIDs, selLocIDs, selSubIDs);

                    MessageBox.Show("New course successfully added!");

                    App.MainPage.activeScreenFrame.Content = new CourseSearch();
                }
                else
                {
                    MessageBox.Show("Please ensure values for Duration and Fee are numbers");
                }
            }
            else
            {
                MessageBox.Show("Please ensure at least one location, semester and subject is selected");
            }




        }

        private void goBackBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();

        }
    }
}
