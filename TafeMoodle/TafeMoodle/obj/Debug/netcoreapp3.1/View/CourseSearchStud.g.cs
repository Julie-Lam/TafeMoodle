﻿#pragma checksum "..\..\..\..\View\CourseSearchStud.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "30DA0161BAD49D593D67A4DE7D1F953D5B1EA371"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Controls.Ribbon;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;
using TafeMoodle.View;


namespace TafeMoodle.View {
    
    
    /// <summary>
    /// CourseSearchStud
    /// </summary>
    public partial class CourseSearchStud : System.Windows.Controls.Page, System.Windows.Markup.IComponentConnector {
        
        
        #line 51 "..\..\..\..\View\CourseSearchStud.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox searchInput;
        
        #line default
        #line hidden
        
        
        #line 57 "..\..\..\..\View\CourseSearchStud.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox searchFilter;
        
        #line default
        #line hidden
        
        
        #line 69 "..\..\..\..\View\CourseSearchStud.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button viewAllCoursesBtn;
        
        #line default
        #line hidden
        
        
        #line 74 "..\..\..\..\View\CourseSearchStud.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button searchCourseBtn;
        
        #line default
        #line hidden
        
        
        #line 85 "..\..\..\..\View\CourseSearchStud.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.DataGrid myDataGrid;
        
        #line default
        #line hidden
        
        
        #line 105 "..\..\..\..\View\CourseSearchStud.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button seeMoreBtn;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "5.0.6.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/TafeMoodle;component/view/coursesearchstud.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\..\View\CourseSearchStud.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "5.0.6.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.searchInput = ((System.Windows.Controls.TextBox)(target));
            return;
            case 2:
            this.searchFilter = ((System.Windows.Controls.ComboBox)(target));
            return;
            case 3:
            this.viewAllCoursesBtn = ((System.Windows.Controls.Button)(target));
            
            #line 71 "..\..\..\..\View\CourseSearchStud.xaml"
            this.viewAllCoursesBtn.Click += new System.Windows.RoutedEventHandler(this.viewAllCoursesBtn_Click);
            
            #line default
            #line hidden
            return;
            case 4:
            this.searchCourseBtn = ((System.Windows.Controls.Button)(target));
            
            #line 76 "..\..\..\..\View\CourseSearchStud.xaml"
            this.searchCourseBtn.Click += new System.Windows.RoutedEventHandler(this.searchBtn_Click);
            
            #line default
            #line hidden
            return;
            case 5:
            this.myDataGrid = ((System.Windows.Controls.DataGrid)(target));
            return;
            case 6:
            this.seeMoreBtn = ((System.Windows.Controls.Button)(target));
            
            #line 106 "..\..\..\..\View\CourseSearchStud.xaml"
            this.seeMoreBtn.Click += new System.Windows.RoutedEventHandler(this.seeMoreBtn_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

