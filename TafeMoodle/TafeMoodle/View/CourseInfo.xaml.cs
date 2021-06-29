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
using TafeMoodle.Model;

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for CourseInfo.xaml
    /// </summary>
    public partial class CourseInfo : Page
    {
        DataAccessLayer dataAccess = new DataAccessLayer();
        string name;
        int duration;
        double fee;
        int thisCourseID;


        public CourseInfo(int courseID)
        {
            InitializeComponent();
            thisCourseID = courseID;

            //Populate this screen
            Course aCourse = dataAccess.getCourseInfoByID(courseID);

            this.DataContext = aCourse;

            //Populate Locationlist 
            if (aCourse.locationList.Count > 0)
            {
                foreach (var location in aCourse.locationList)
                {
                    locationsLB.Items.Add(location.address);
                }
            }
            else
            {
                locationsLB.Items.Add("Not currently available at any locations");
            }


            //Populate SubjectsList
            foreach (Subject sub in aCourse.subjectList)
            {
                subjectsLB.Items.Add(sub.subName);
            }


            //Populate Semester
            foreach (Semester sem in aCourse.semesterList)
            {
                semsLB.Items.Add(sem.semStartDate + " - " + sem.semFinishDate);
            }



            //Populate enrolled students
            List<Student> enrolledStuds = new List<Student>();

            enrolledStuds = dataAccess.getEnrolledStudsByCourseID(courseID);

            foreach (Student stud in enrolledStuds)
            {
                enrolledStudsLB.Items.Add(stud.userID + ": " + stud.firstName + " " + stud.lastName);
            }


        }

        private void deleteBtn_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Once you delete this record, it cannot be recovered", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                dataAccess.deleteCourseByID(thisCourseID);

                App.MainPage.activeScreenFrame.Content = new CourseSearch();
            }

        }

        private void saveBtn_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Once you save this record, it cannot be reverted", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                Trace.WriteLine("Student record updated");

                name = courseNameTxt.Text;
                bool durationIsInt = int.TryParse(durationTxt.Text, out duration);
                bool feeIsDouble = double.TryParse(feeTxt.Text, out fee);

                if (string.IsNullOrEmpty(name) || string.IsNullOrWhiteSpace(name) ||
                    string.IsNullOrEmpty(durationTxt.Text) || string.IsNullOrWhiteSpace(durationTxt.Text) ||
                    string.IsNullOrEmpty(feeTxt.Text) || string.IsNullOrWhiteSpace(feeTxt.Text)
                    )
                {
                    MessageBox.Show("Cannot save changes with empty fields");



                }
                else if (durationIsInt == false || feeIsDouble == false)
                {
                    MessageBox.Show("Values for Duration and Fee must be valid numerals, e.g. 100");
                }
                else
                {
                    //save to db 
                    dataAccess.updateCourseNameDurFee(thisCourseID, name, duration, fee);
                    App.MainPage.activeScreenFrame.Content = new CourseSearch();
                }

            }
        }

        private void goBackBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }
    }
}
