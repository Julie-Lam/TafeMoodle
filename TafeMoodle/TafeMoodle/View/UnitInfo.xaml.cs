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
    /// Interaction logic for UnitInfo.xaml
    /// </summary>
    public partial class UnitInfo : Page
    {

        DataAccessLayer dataAccess = new DataAccessLayer();

        int thisUnitID;

        public UnitInfo(int unitID)
        {
            InitializeComponent();

            thisUnitID = unitID;

            //Populate this screen
            Unit unit = dataAccess.getUnitInfoByID(thisUnitID);

            this.DataContext = unit;

            //Populate assessmentLB
            foreach (Assessment ass in unit.assessmentList)
            {
                assessmentLB.Items.Add(ass.assessmentID + " " + ass.assessmentName + " " + ass.assessmentType);
            }
        }

        private void goBackBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.GoBack();
        }

        private void deleteBtn_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBox.Show("Once you delete this record, it cannot be recovered", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                dataAccess.deleteUnitByID(thisUnitID);

                App.MainPage.activeScreenFrame.Content = new UnitSearch();
            }
        }

        private void saveBtn_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
