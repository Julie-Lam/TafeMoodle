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
    /// Interaction logic for Home.xaml
    /// </summary>
    public partial class Dashboard : UserControl
    {
        DataAccessLayer dataAccess = new DataAccessLayer();

        int thisStudID;

        public Dashboard(int studID)
        {
            InitializeComponent();
            thisStudID = studID;

            //Populate this screen
            Student aStudent = dataAccess.getStudInfoByID(thisStudID);

            this.DataContext = aStudent;

            greetingTxt.Text += aStudent.firstName + "!";


            //Load all enrolled courses from db 
            courseDataGrid.ItemsSource = dataAccess.getAllEnrolledCoursesByStudIDDataTable(thisStudID).DefaultView;

            //setCrsDataGridHeaders(courseDataGrid);

        }

        private void unenrollBtn_Click(object sender, RoutedEventArgs e)
        {
            Course selectedCourse = new Course();

            DataRowView selectedItem = (DataRowView)courseDataGrid.SelectedItem;

            if (selectedItem == null)
            {
                MessageBox.Show("Please select a course first to unenroll from");
            }
            else
            {

                if (MessageBox.Show("Once you unenroll, any payment made will not be refunded", "Confirmation", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
                {

                    selectedCourse.courseID = (int)selectedItem[0];

                    if (dataAccess.isCourseExistByID(selectedCourse.courseID))
                    {

                        dataAccess.unEnrollStud(selectedCourse.courseID, thisStudID);

                        MessageBox.Show("You have been successfully unenrolled from this course");

                        App.MainPageStud.activeScreenFrame.Content = new Dashboard(thisStudID);
                    }
                    else
                    {
                        throw new Exception();
                    }

                }


            }
        }

        private void payBtn_Click(object sender, RoutedEventArgs e)
        {

            Course selectedCourse = new Course();

            DataRowView selectedItem = (DataRowView)courseDataGrid.SelectedItem;

            if (selectedItem == null)
            {
                MessageBox.Show("Please select a course first to make a payment");
            }
            else
            {
                selectedCourse.courseID = (int)selectedItem[0];

                if (dataAccess.isCourseExistByID(selectedCourse.courseID))
                {
                    double.TryParse(paymentAmountTxt.Text, out double payment);


                    dataAccess.payEnrolledCourse(payment, thisStudID, selectedCourse.courseID);

                    MessageBox.Show("Thanks for making a payment!");

                    App.MainPageStud.activeScreenFrame.Content = new Dashboard(thisStudID);
                }
                else
                {
                    throw new Exception();
                }
            }

        }
    }
}
