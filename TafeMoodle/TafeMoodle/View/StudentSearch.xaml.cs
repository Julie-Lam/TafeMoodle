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
    /// Interaction logic for StudentSearch.xaml
    /// </summary>
    public partial class StudentSearch : Page
    {
        string searchStr;
        DataAccessLayer dataAccess = new DataAccessLayer();

        public StudentSearch()
        {
            InitializeComponent();
        }


        private void setDataGridHeaders(DataGrid mydataGrid)
        {
            myDataGrid.Columns[0].Header = "Student ID";
            myDataGrid.Columns[1].Header = "First Name";
            myDataGrid.Columns[2].Header = "Surname";
            myDataGrid.Columns[3].Header = "Address";
            myDataGrid.Columns[4].Header = "Mobile Number";
            myDataGrid.Columns[5].Header = "Sex";
            myDataGrid.Columns[6].Header = "Username";
        }


        private void seeMoreBtn_Click(object sender, RoutedEventArgs e)
        {

            Student selectedStudent = new Student();

            DataRowView selectedItem = (DataRowView)myDataGrid.SelectedItem;

            if (selectedItem == null)
            {
                MessageBox.Show("Please select a student first to see more information");
            }
            else
            {
                selectedStudent.userID = (int)selectedItem[0];

                if (dataAccess.isStudExistByID(selectedStudent.userID))
                {
                    App.MainPage.activeScreenFrame.Content = new StudentInfo(selectedStudent.userID);
                }
                else
                {
                    throw new Exception();
                }
            }
        }

        private void viewAllStudsBtn_Click(object sender, RoutedEventArgs e)
        {
            //Load all students from db 
            myDataGrid.ItemsSource = dataAccess.getAllStudentsDT().DefaultView;

            setDataGridHeaders(myDataGrid);
        }

        private void searchStudBtn_Click(object sender, RoutedEventArgs e)
        {
            searchStr = searchInput.Text.ToLower();

            if (string.IsNullOrWhiteSpace(searchStr) || string.IsNullOrEmpty(searchStr))
            {
                MessageBox.Show("Please enter a value to search");
            }
            else
            {
                //Search by Student name
                if (searchFilter.SelectedIndex == 0)
                {
                    //Displays student deets where studentNames are similar to input string

                    myDataGrid.ItemsSource = dataAccess.getStudByName(searchStr).DefaultView;

                    setDataGridHeaders(myDataGrid);
                }

                //Search by Student ID
                else if (searchFilter.SelectedIndex == 1)
                {
                    //Displays student deets where studIDs match input string
                    if (Int32.TryParse(searchStr, out int result))
                    {

                        myDataGrid.ItemsSource = dataAccess.getStudByID(result).DefaultView;

                        setDataGridHeaders(myDataGrid);
                    }
                }
            }
        }


    }
}
