using System;
using System.Collections.Generic;
using System.Data;
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
    /// Interaction logic for TeacherSearch.xaml
    /// </summary>
    public partial class TeacherSearch : Page
    {

        string searchStr;
        DataAccessLayer dataAccess = new DataAccessLayer();


        public TeacherSearch()
        {
            InitializeComponent();
        }

        private void setDataGridHeaders(DataGrid mydataGrid)
        {
            myDataGrid.Columns[0].Header = "Teacher ID";
            myDataGrid.Columns[1].Header = "First Name";
            myDataGrid.Columns[2].Header = "Surname";
            myDataGrid.Columns[3].Header = "Address";
            myDataGrid.Columns[4].Header = "Mobile Number";
            myDataGrid.Columns[5].Header = "Sex";
            myDataGrid.Columns[6].Header = "Username";
        }

        private void seeMoreBtn_Click(object sender, RoutedEventArgs e)
        {

            Teacher selectedTeacher = new Teacher();

            DataRowView selectedItem = (DataRowView)myDataGrid.SelectedItem;

            if (selectedItem == null)
            {
                MessageBox.Show("Please select a Teacher first to see more information");
            }
            else
            {
                selectedTeacher.userID = (int)selectedItem[0];

                if (dataAccess.isTeachExistByID(selectedTeacher.userID))
                {
                    App.MainPage.activeScreenFrame.Content = new TeacherInfo(selectedTeacher.userID);
                }
                else
                {
                    throw new Exception();
                }
            }
        }

        private void viewAllTeachsBtn_Click(object sender, RoutedEventArgs e)
        {
            //Load all teachers from db 
            myDataGrid.ItemsSource = dataAccess.getAllTeachersDT().DefaultView;

            setDataGridHeaders(myDataGrid);
        }

        private void searchTeachsBtn_Click(object sender, RoutedEventArgs e)
        {
            searchStr = searchInput.Text.ToLower();

            if (string.IsNullOrWhiteSpace(searchStr) || string.IsNullOrEmpty(searchStr))
            {
                MessageBox.Show("Please enter a value to search");
            }
            else
            {
                //Search by Teacher name
                if (searchFilter.SelectedIndex == 0)
                {
                    //Displays teacher deets where teacherNames are similar to input string

                    myDataGrid.ItemsSource = dataAccess.getTeachByName(searchStr).DefaultView;

                    setDataGridHeaders(myDataGrid);
                }

                //Search by Teacher ID
                else if (searchFilter.SelectedIndex == 1)
                {
                    //Displays student deets where studIDs match input string
                    if (Int32.TryParse(searchStr, out int result))
                    {
                        myDataGrid.ItemsSource = dataAccess.getTeachByID(result).DefaultView;

                        setDataGridHeaders(myDataGrid);
                    }
                }
            }
        }
    }
}
