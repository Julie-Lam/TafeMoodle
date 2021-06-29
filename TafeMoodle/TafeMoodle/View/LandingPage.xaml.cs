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

namespace TafeMoodle.View
{
    /// <summary>
    /// Interaction logic for LandingPage.xaml
    /// </summary>
    public partial class LandingPage : Page
    {

        DataAccessLayer dataAccessLayer = new DataAccessLayer();

        public LandingPage(int teacherID)
        {
            InitializeComponent();


            activeScreenFrame.Content = new CourseSearch();
            App.MainPage = this;
        }

        private void searchBtn_Click(object sender, RoutedEventArgs e)
        {
            CourseSearch courseSearchPage = new CourseSearch();
            activeScreenFrame.Content = courseSearchPage;
        }

        private void searchSubsBtn_Click(object sender, RoutedEventArgs e)
        {
            SubjectSearch subjectSearchPage = new SubjectSearch();
            activeScreenFrame.Content = subjectSearchPage;
        }

        private void searchUnitsBtn_Click(object sender, RoutedEventArgs e)
        {
            UnitSearch unitSearchPage = new UnitSearch();
            activeScreenFrame.Content = unitSearchPage;
        }

        private void searchTeachsBtn_Click(object sender, RoutedEventArgs e)
        {
            TeacherSearch teacherSearchPage = new TeacherSearch();
            activeScreenFrame.Content = teacherSearchPage;
        }

        private void searchStudsBtn_Click(object sender, RoutedEventArgs e)
        {
            StudentSearch studentSearchPage = new StudentSearch();
            activeScreenFrame.Content = studentSearchPage;
        }

        private void signOutBtn_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new LoginPage());
        }
    }
}
