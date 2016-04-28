### `下拉列表 Demo For Stu`

===

#### `Code:`

	HSelectList * selectLst = [[HSelectList alloc] initWithFrame:CGRectMake(100, 150, 100, 40)];
	selectLst.dataList = @[@"中国",@"美国",@"其他"];
	selectLst.currentSelected = 1;
	[self.view addSubview:selectLst];

#### `Portrait`

![image](https://github.com/iFallen/HSelect_List/raw/master/ScreenShots/1.png)

---

#### `Landscape`

![image](https://github.com/iFallen/HSelect_List/raw/master/ScreenShots/2.png)

