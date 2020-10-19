using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OrmeAutomation
{
    public partial class Default : Page
    {


        private helpers.SqlHelper m_sqlHelper =new  helpers.SqlHelper();
		private helpers.ErrorHandler m_errorHandler = new helpers.ErrorHandler();
		private OrmeAutomation.Properties.Settings m_settings = new OrmeAutomation.Properties.Settings();

		public DataTable machinesTable;
		protected void Page_Load(object sender, EventArgs e)
		{
			
			//DoMachineTable();
			//ProsessData();
			machineView.DataSource = m_sqlHelper.FromSql("SELECT * FROM MachOnline ORDER BY cast(MachId as int)");
			machineView.DataBind();
			

		}

		protected void DoMachineTable()
        {
			machinesTable = new DataTable();
			machinesTable.Columns.Add("MachId",typeof(string));
			machinesTable.Columns.Add("MachName", typeof(string));
			machinesTable.Columns.Add("Status", typeof(string));
			machinesTable.Columns.Add("EffColor", typeof(string));
			machinesTable.Columns.Add("RunTime", typeof(string));
			machinesTable.Columns.Add("StopTime", typeof(string));
			machinesTable.Columns.Add("Efficiency", typeof(string));
			machinesTable.Columns.Add("Head", typeof(string));
			machinesTable.Columns.Add("PrdcSpeed", typeof(string));
			machinesTable.Columns.Add("Total", typeof(string));
		}

		protected string[] Converts(string WorkTime, string StopTime,string HeadCount,string PrdcMin)
		{
			double wT = Convert.ToDouble(WorkTime);
			double sT = Convert.ToDouble(StopTime);
			TimeSpan tW = TimeSpan.FromSeconds(wT);
			TimeSpan tS = TimeSpan.FromSeconds(sT);
			decimal m_headCount = 0M;
			decimal m_prdcMin=0M;
			double eficency= ((wT / (wT + sT)) * 100.0);
			string effColor = null;
			if (!String.IsNullOrEmpty(HeadCount))
				m_headCount = Convert.ToDecimal(HeadCount);
			if (!String.IsNullOrEmpty(PrdcMin))
				m_prdcMin = Convert.ToDecimal(PrdcMin);
			decimal produceTotal = m_headCount * m_prdcMin * (decimal)tW.TotalMinutes;
			if(eficency>80.0)
            {
				effColor= "white";

            }
			else
            {
				effColor="red";
            }
			return new string[] { effColor,
								  tW.ToString() ,
								  tS.ToString(),
								  string.Format("{0:0}",eficency),
								  string.Format("{0:0}",m_headCount),
								  string.Format("{0:0.##}",PrdcMin),
								  string.Format("{0:0,0.##}",produceTotal)
								  };
								 
		}

		protected void ChangeShift()
        {

        }
		
        protected void ProsessData()
        {
            try
            {
				string shiftDate = null;
				DateTime today = DateTime.Now;
				
				if((today.Hour>=Convert.ToInt32(m_settings.NightShift)&&today.Minute>0) || today.Hour < Convert.ToInt32(m_settings.DayShift) )
                {
					if (today.Hour > 0 && today.Hour < 7 )
					{
						today = new DateTime(today.Year, today.Month, today.Day-1, Convert.ToInt32(m_settings.NightShift), 0, 0);
					}
                    else
                    {
						today = new DateTime(today.Year, today.Month, today.Day, Convert.ToInt32(m_settings.NightShift), 0, 0);

					}
				}
				else
                {
					today = new DateTime(today.Year, today.Month, today.Day, Convert.ToInt32(m_settings.DayShift), 0, 0);

				}
				shiftDate = today.ToString("yyyy-MM-dd HH:mm:ss.fff");
				DataTable LogTable = m_sqlHelper.FromSql(string.Format(
										   @"									declare @logTimeFirst as datetime
									declare @logTimeSecond as datetime
									declare @sumLogTimeRun as int=0
									declare @sumLogTimeStop as int=0
									declare @startJobTime as dateTime
									declare @stopJobTime as dateTime
									declare @machineIDFirst as int
									declare @machineIDSecond as int
									declare @status as int=0
									declare @statusTime as datetime
									declare @statusFirst as int
									declare @statusSecond as int
									declare @tempTable TABLE
									(
										WorkTime int,
										StopTime int,
										MachId int,
										Status int
									)
									declare crsLogTime  cursor for
									SELECT DISTINCT  logTime,machineID,status FROM LogTable WHERE logTime>'{0}'  order by machineID,logTime
									open crsLogTime
									fetch next from crsLogTime into @logTimeFirst,@machineIDFirst,@statusFirst
									fetch next from crsLogTime into @logTimeSecond,@machineIDSecond,@statusSecond

									while @@FETCH_STATUS=0 
									Begin
										IF @machineIDFirst=@machineIDSecond
											Begin 
												IF @statusFirst=@statusSecond 
													Begin
														IF @statusFirst=1 
															begin
																set @sumLogTimeRun=@sumLogTimeRun+DATEDIFF(SECOND,  @logTimeFirst,@logTimeSecond)
															end
														ELSE
															begin
																set @sumLogTimeStop=@sumLogTimeStop+DATEDIFF(SECOND,  @logTimeFirst,@logTimeSecond)
															end
													end
											end
										ELSE
											Begin
												INSERT INTO @tempTable (WorkTime,MachId,Status,StopTime) VALUES (@sumLogTimeRun,@machineIDFirst,@status,@sumLogTimeStop)
												set @sumLogTimeStop=0
												set @sumLogTimeRun=0

											End
										set @logTimeFirst=@logTimeSecond
										set @statusFirst=@statusSecond
										set @machineIDFirst=@machineIDSecond
										set @status=@statusFirst
										fetch next from crsLogTime into @logTimeSecond,@machineIDSecond,@statusSecond
										
									end
										INSERT INTO @tempTable (WorkTime,MachId,Status,StopTime) VALUES (@sumLogTimeRun,@machineIDFirst,@status,@sumLogTimeStop)

									CLOSE crsLogTime
									DEALLOCATE crsLogTime
											
											
												
												
									
									SELECT t.MachId,t.WorkTime,t.StopTime,d.name,m.HeadCount,m.PrdcMin,t.Status FROM  @tempTable t join DeviceTable d on t.MachId=d.id 
									left Outer join MachJobTable m on t.MachId=m.MachID 
								

",
										   shiftDate
										   ));
                if(LogTable.Rows.Count>0)
                {
					
					machinesTable.Clear();
					foreach(DataRow dr in LogTable.Rows)
                    {
						string statusColor = null;
						if(String.Equals(dr["Status"].ToString(),"1"))
						{
							statusColor = "#1949a7";

						}
						else
                        {
							statusColor = "#980d05";
						}
						List<String> row = new List<String>();
						row.Add(dr["MachId"].ToString());
						row.Add(dr["name"].ToString() );
						row.Add(statusColor);
						row.AddRange(Converts(dr["WorkTime"].ToString(), 
											dr["StopTime"].ToString(),
											dr["HeadCount"].ToString(),
											dr["PrdcMin"].ToString()));

						machinesTable.Rows.Add(row.ToArray());
							

					}




				}



			}
            catch (Exception exc)
            {

				m_errorHandler.Handle(exc);

			}
        }

        protected void buttonPopup_Click(object sender, EventArgs e)
        {
			Button btn = (Button)sender;
			UpdateTimer.Enabled = false;
			lblModalTitle.Text =btn.Text + " İsimli makinenin iş bilgileri" ;
			hdnMacId.Value = btn.ToolTip;
			ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
			upModal.Update();
		}

        protected void btnModalSave_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                string sql = string.Format("UPDATE MachJobTable SET HeadCount={0},PrdcMin={1} WHERE MachID={2}",
                    drpdownHeadCount.SelectedValue,
                    prdcMin.Text,
                    hdnMacId.Value);
                m_sqlHelper.ToSql(sql);
				UpdateTimer.Enabled = true;
				ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal('hide');", true);
			}
            catch (Exception exc)
            {

				m_errorHandler.Handle(exc);
            }

		}

        protected void UpdateTimer_Tick(object sender, EventArgs e)
        {
            //ProsessData();
            machineView.DataSource = m_sqlHelper.FromSql("SELECT * FROM MachOnline ORDER BY cast(MachId as int)");
			machineView.DataBind();

        }
    }
}