﻿#pragma checksum "..\..\..\..\View\TeacherSearch.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "B218BC97D73803C1ADA5B920340D4819B9A24BDF"
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
    /// TeacherSearch
    /// </summary>
    public partial class TeacherSearch : System.Windows.Controls.Page, System.Windows.Markup.IComponentConnector {
        
        
        #line 52 "..\..\..\..\View\TeacherSearch.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox searchInput;
        
        #line default
        #line hidden
        
        
        #line 58 "..\..\..\..\View\TeacherSearch.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox searchFilter;
        
        #line default
        #line hidden
        
        
        #line 70 "..\..\..\..\View\TeacherSearch.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button viewAllTeachsBtn;
        
        #line default
        #line hidden
        
        
        #line 76 "..\..\..\..\View\TeacherSearch.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button searchTeachsBtn;
        
        #line default
        #line hidden
        
        
        #line 88 "..\..\..\..\View\TeacherSearch.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.DataGrid myDataGrid;
        
        #line default
        #line hidden
        
        
        #line 108 "..\..\..\..\View\TeacherSearch.xaml"
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
            System.Uri resourceLocater = new System.Uri("/TafeMoodle;component/view/teachersearch.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\..\View\TeacherSearch.xaml"
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
            this.viewAllTeachsBtn = ((System.Windows.Controls.Button)(target));
            
            #line 72 "..\..\..\..\View\TeacherSearch.xaml"
            this.viewAllTeachsBtn.Click += new System.Windows.RoutedEventHandler(this.viewAllTeachsBtn_Click);
            
            #line default
            #line hidden
            return;
            case 4:
            this.searchTeachsBtn = ((System.Windows.Controls.Button)(target));
            
            #line 78 "..\..\..\..\View\TeacherSearch.xaml"
            this.searchTeachsBtn.Click += new System.Windows.RoutedEventHandler(this.searchTeachsBtn_Click);
            
            #line default
            #line hidden
            return;
            case 5:
            this.myDataGrid = ((System.Windows.Controls.DataGrid)(target));
            return;
            case 6:
            this.seeMoreBtn = ((System.Windows.Controls.Button)(target));
            
            #line 109 "..\..\..\..\View\TeacherSearch.xaml"
            this.seeMoreBtn.Click += new System.Windows.RoutedEventHandler(this.seeMoreBtn_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

