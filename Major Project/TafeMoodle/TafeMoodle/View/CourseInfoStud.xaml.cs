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
    /// Interaction logic for CourseInfoStud.xaml
    /// </summary>
    public partial class CourseInfoStud : Page
    {
        DataAccessLayer dataAccess = new DataAccessLayer();
        int thisCourseID, activeStudID;


        public CourseInfoStud(int courseID, int studID)
        {
            InitializeComponent();
            thisCourseID = courseID;
            activeStudID = studID;

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


        private void enrollBtn_Click(object sender, RoutedEventArgs e)
        {
            if (dataAccess.enrollStud(thisCourseID, activeStudID))
            {
                MessageBox.Show("Successfully enrolled in course!");
            }
            else
            {
                MessageBox.Show("Error enrolling, looks like you've already enrolled in this course!");
            }

        }

        private void goBackBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }
    }
}
