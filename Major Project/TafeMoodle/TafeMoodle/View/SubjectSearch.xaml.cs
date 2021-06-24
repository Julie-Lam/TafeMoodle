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
using TafeMoodle.Model;
using TafeMoodle.Data_Access_Layer;

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for SubjectSearch.xaml
    /// </summary>
    public partial class SubjectSearch : Page
    {
        string searchStr;
        DataAccessLayer dataAccess = new DataAccessLayer();

        public SubjectSearch()
        {
            InitializeComponent();
        }

        private void setDataGridHeaders(DataGrid mydataGrid)
        {
            myDataGrid.Columns[0].Header = "Subject ID";
            myDataGrid.Columns[1].Header = "Subject Name";
        }

        private void seeMoreBtn_Click(object sender, RoutedEventArgs e)
        {
            Subject selectedSubject = new Subject();

            DataRowView selectedItem = (DataRowView)myDataGrid.SelectedItem;

            if (selectedItem == null)
            {
                MessageBox.Show("Please select a subject first to see more information");
            }
            else
            {
                selectedSubject.subID = (int)selectedItem[0];

                if (dataAccess.isSubjectExistByID(selectedSubject.subID))
                {
                    App.MainPage.activeScreenFrame.Content = new SubjectInfo(selectedSubject.subID);

                }
                else
                {
                    throw new Exception();
                }
            }
        }

        private void addNewBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new SubjectAdd());
        }


        private void viewAllSubsBtn_Click(object sender, RoutedEventArgs e)
        {
            //Load all students from db 
            myDataGrid.ItemsSource = dataAccess.getAllSubjectsDT().DefaultView;

            setDataGridHeaders(myDataGrid);
        }


        private void searchSubsBtn_Click(object sender, RoutedEventArgs e)
        {
            searchStr = searchInput.Text.ToLower();

            if (string.IsNullOrWhiteSpace(searchStr) || string.IsNullOrEmpty(searchStr))
            {
                MessageBox.Show("Please enter a value to search");
            }
            else
            {
                //Search by Subject name
                if (searchFilter.SelectedIndex == 0)
                {
                    //Displays subject deets where studentNames are similar to input string

                    myDataGrid.ItemsSource = dataAccess.getSubByName(searchStr).DefaultView;

                    setDataGridHeaders(myDataGrid);
                }

                //Search by Subject ID
                else if (searchFilter.SelectedIndex == 1)
                {
                    //Displays student deets where studIDs match input string
                    if (Int32.TryParse(searchStr, out int result))
                    {
                        myDataGrid.ItemsSource = dataAccess.getSubByID(result).DefaultView;

                        setDataGridHeaders(myDataGrid);
                    }
                }
            }

        }
    }
}
