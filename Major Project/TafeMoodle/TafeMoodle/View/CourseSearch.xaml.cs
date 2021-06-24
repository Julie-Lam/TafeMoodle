using System;
using System.Collections;
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
using TafeMoodle.Model;
using TafeMoodle.Data_Access_Layer;
using System.Data;

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for CourseSearch.xaml
    /// </summary>
    public partial class CourseSearch : Page
    {
        string searchStr;
        DataAccessLayer dataAccess = new DataAccessLayer();
        //List<Course> allCourses;

        public CourseSearch()
        {
            InitializeComponent();
            //allCourses = dataAccess.getAllCoursesList();
        }
        private void setDataGridHeaders(DataGrid mydataGrid)
        {
            mydataGrid.Columns[0].Header = "Course ID";
            mydataGrid.Columns[1].Header = "Course";
            mydataGrid.Columns[2].Header = "Duration (Weeks)";
            mydataGrid.Columns[3].Header = "Fee";
            mydataGrid.Columns[4].Header = "Mode";
        }

        private void searchBtn_Click(object sender, RoutedEventArgs e)
        {
            searchStr = searchInput.Text.ToLower();

            if (string.IsNullOrWhiteSpace(searchStr) || string.IsNullOrEmpty(searchStr))
            {
                MessageBox.Show("Please enter a value to search");
            }
            else
            {
                //Search by Course name
                if (searchFilter.SelectedIndex == 0)
                {
                    //Displays course deets of courseNames that are similar to input string

                    myDataGrid.ItemsSource = dataAccess.getCourseByName(searchStr).DefaultView;

                    setDataGridHeaders(myDataGrid);
                }

                //Search by Course ID
                else if (searchFilter.SelectedIndex == 1)
                {
                    //Displays course deets of courseIDs that match input string
                    if (Int32.TryParse(searchStr, out int result))
                    {
                        Trace.WriteLine("A valid course ID was detected");

                        myDataGrid.ItemsSource = dataAccess.getCourseByID(result).DefaultView;

                        setDataGridHeaders(myDataGrid);
                    }
                }
            }
        }

        private void viewAllCoursesBtn_Click(object sender, RoutedEventArgs e)
        {
            //Load all courses from db 
            myDataGrid.ItemsSource = dataAccess.getAllCoursesDataTable().DefaultView;

            setDataGridHeaders(myDataGrid);
        }

        private void seeMoreBtn_Click(object sender, RoutedEventArgs e)
        {
            Course selectedCourse = new Course();

            DataRowView selectedItem = (DataRowView)myDataGrid.SelectedItem;

            if (selectedItem == null)
            {
                MessageBox.Show("Please select a course first to see more information");
            }
            else
            {
                selectedCourse.courseID = (int)selectedItem[0];

                if (dataAccess.isCourseExistByID(selectedCourse.courseID))
                {
                    Trace.WriteLine("Switched to new page for courseID " + selectedCourse.courseID);
                    App.MainPage.activeScreenFrame.Content = new CourseInfo(selectedCourse.courseID);
                }
                else
                {
                    throw new Exception();
                }
            }
        }



        private void addNewBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new CourseAdd());
        }
    }
}
