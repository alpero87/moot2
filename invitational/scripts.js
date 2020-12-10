

	function checkValues()
	{
		var badFlag = false; var theNumber = 0; var indx = 0;


		var judgeCount = document.getElementById("judgeCount").value; judgeCount++;
		for (indx = 1; indx < judgeCount; indx++)
		{
			for (indx1 = 1; indx1 < 5; indx1++)
			{
				if (!badFlag)
				{
					theNumber = document.getElementById(indx + "A" + indx1).value;
					if ((theNumber < 0) || (theNumber > 100) || (isNaN(theNumber))) { badFlag = true; }
					theNumber = document.getElementById(indx + "B" + indx1).value;
					if (!badFlag) { if ((theNumber < 0) || (theNumber > 100) || (isNaN(theNumber))) { badFlag = true; }  }
					theNumber = document.getElementById(indx + "C" + indx1).value;
					if (!badFlag) { if ((theNumber < 0) || (theNumber > 100) || (isNaN(theNumber))) { badFlag = true; }  }
					theNumber = document.getElementById(indx + "D" + indx1).value;
					if (!badFlag) { if ((theNumber < 0) || (theNumber > 100) || (isNaN(theNumber))) { badFlag = true; }  }
				}
			}
		}
		if (badFlag) { alert("One or more scores exceed the permitted range of zero to one hundred."); }

		return !badFlag;
	}