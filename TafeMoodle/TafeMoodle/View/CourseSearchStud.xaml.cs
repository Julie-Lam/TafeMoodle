using System;
using System.Collections.Generic;
using System.Data;
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
    /// Interaction logic for CourseSearchStud.xaml
    /// </summary>
    public partial class CourseSearchStud : Page
    {
        string searchStr;
        DataAccessLayer dataAccess = new DataAccessLayer();

        int activeStudID;

        public CourseSearchStud(int studID)
        {
            InitializeComponent();
            activeStudID = studID;
        }

        private void setDataGridHeaders(DataGrid mydataGrid)
        {
            myDataGrid.Columns[0].Header = "Course ID";
            myDataGrid.Columns[1].Header = "Course";
            myDataGrid.Columns[2].Header = "Duration (Weeks)";
            myDataGrid.Columns[3].Header = "Fee";
            myDataGrid.Columns[4].Header = "Mode";
        }

        private void viewAllCoursesBtn_Click(object sender, RoutedEventArgs e)
        {
            //Load all courses from db 
            myDataGrid.ItemsSource = dataAccess.getAllCoursesDataTable().DefaultView;

            setDataGridHeaders(myDataGrid);
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

                    App.MainPageStud.activeScreenFrame.Content = new CourseInfoStud(selectedCourse.courseID, activeStudID);
                    //App.MainPageStud.activeScreenFrame.Content = new CourseInfoStud(selectedCourse.courseID);
                }
                else
                {
                    throw new Exception();
                }
            }
        }
    }
}
