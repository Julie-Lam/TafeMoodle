   M S B A M L   `   `   `  ����E  ATafeMoodle, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null1clr-namespace:TafeMoodle.ViewTafeMoodle.View  5           TafeMoodle.View.UnitSearch   5      \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      /localclr-namespace:TafeMoodle.View     5        N� Title$  
UnitSearch��5	      .��5      �  � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $��* �6   �� 5      $��* �6    � RowDefinitions 5   
   �� 5      $��75 �6   �� 5      $	��100 �6   �� 5      $��* �6   �� 5      $	��100 �6   .+�5   
   �� $��3��6   $��4��5       J� Opacity$	 0.8Q�5      ��5      �� 5      .��5      �  � Color$ #7be9f6��6#    � Offset$	 0.0Q�63   � 5      $ #f083da��6#   $ 1Q�63   5      5!      � 5#   
   $��0��6   $��3��6   $��0��63   .+�5$      �� $
��Unit��6   $��30(�5%      
�������$��Center=�5'      $��	0 10 0 10q�5(      5)      � 5*   
   $��0��6   $��3��6   $��1��63   .+�5+      �� $��	20 0 20 0q�6   
���p�.+�5-      ��  �� Orientation$ 
Horizontal=�6   $��	20 0 20 0q�66   $��Center=�5.      .+�5/      �� $	��200��6!   $��5 0 5 0q�6-   .+�51      �� $��Search Unit: ��6    $��18(�68   
�������52   5   �� 53      -   5         ��Name$ searchInput��53   "   54      �� 56      $	��200��6!   $��5 0 5 0q�6-   .+�57      �� $
��By: ��6    $��18(�6/   
�������58   5   �� 59      -   5         ��Name$ searchFilter��59   #   .@�5:      �� 	 �� 
IsSelected$
	 True��6+   .��6=   	Unit Name6H   �� 5;      .��6+   	Unit ID64   5<      5?      5@      �� 5A      $��	0 20 0 20q�6   $ 
Horizontal=�60   $��Center=�5B      .+�5D      �� $��0 0 10 0q�6!   .+�5E      �� -   5        
 ��Name$
 viewAllUnitsBtn��5E   !   $��View All Units��5F   !   5G   !   5I      �� 5J      .+�5K      �� -   5        $
 searchUnitsBtn��5K   !   $��Search Units��5L      5M   !   5O      5Q      5S      5T      � 5U   
   $��0��6   $��3��6   $��2��63   $��	20 0 20 0q�5V      .+�5W      &   System.Windows.Controls.DataGrid  -   5        $��
myDataGrid��5W      $��Stretch=�5X      $��Stretch=�5Y         CanUserAddRows$ False��5Z         SelectionMode$ Single=�5[      5]      � 5_   
   $��0��6   $��3��6   $��3��63   $��	20 0 20 0q�5`      .+�5g      �� -   5        $
 
seeMoreBtn��5k      $��See More��5g      $��Center=�5h      $��Center=�5i      $��10q�5j      5l      �� 5m      -   5        $
 	addNewBtn��5q      $��Add New��5m      $��Right=�5n      $��Center=�5o      $��10q�5p      5r      5s      5t      5u      