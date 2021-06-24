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
    /// Interaction logic for UnitSearch.xaml
    /// </summary>
    public partial class UnitSearch : Page
    {
        string searchStr;
        DataAccessLayer dataAccess = new DataAccessLayer();

        public UnitSearch()
        {
            InitializeComponent();
        }

        private void setDataGridHeaders(DataGrid mydataGrid)
        {
            myDataGrid.Columns[0].Header = "Unit ID";
            myDataGrid.Columns[1].Header = "Unit Name";
            myDataGrid.Columns[2].Header = "Unit Type";
        }


        private void seeMoreBtn_Click(object sender, RoutedEventArgs e)
        {
            Unit selectedUnit = new Unit();

            DataRowView selectedItem = (DataRowView)myDataGrid.SelectedItem;

            if (selectedItem == null)
            {
                MessageBox.Show("Please select a unit first to see more information");
            }
            else
            {
                selectedUnit.unitID = (int)selectedItem[0];

                if (dataAccess.isUnitExistByID(selectedUnit.unitID))
                {
                    App.MainPage.activeScreenFrame.Content = new UnitInfo(selectedUnit.unitID);

                }
                else
                {
                    throw new Exception();
                }
            }
        }

        private void viewAllUnitsBtn_Click(object sender, RoutedEventArgs e)
        {
            //Load all units from db 
            myDataGrid.ItemsSource = dataAccess.getAllUnitsDT().DefaultView;

            setDataGridHeaders(myDataGrid);
        }

        private void searchUnitsBtn_Click(object sender, RoutedEventArgs e)
        {
            searchStr = searchInput.Text.ToLower();

            if (string.IsNullOrWhiteSpace(searchStr) || string.IsNullOrEmpty(searchStr))
            {
                MessageBox.Show("Please enter a value to search");
            }
            else
            {
                //Search by Unit name
                if (searchFilter.SelectedIndex == 0)
                {
                    //Displays unit deets where unitNames are similar to input string

                    myDataGrid.ItemsSource = dataAccess.getUnitByName(searchStr).DefaultView;

                    setDataGridHeaders(myDataGrid);
                }

                //Search by Unit ID
                else if (searchFilter.SelectedIndex == 1)
                {
                    //Displays student deets where studIDs match input string
                    if (Int32.TryParse(searchStr, out int result))
                    {
                        myDataGrid.ItemsSource = dataAccess.getUnitByID(result).DefaultView;

                        setDataGridHeaders(myDataGrid);
                    }
                }
            }
        }

        private void addNewBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new UnitAdd());
        }
    }
}
