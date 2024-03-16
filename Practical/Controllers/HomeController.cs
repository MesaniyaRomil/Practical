using Microsoft.AspNetCore.Mvc;
using Practical.Models;
using System.Data;
using System.Diagnostics;
using Practical.Helper;
using System;
using Newtonsoft.Json;
using System.Reflection;
using System.Collections;

namespace Practical.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IConfiguration _configuration;
        private readonly IWebHostEnvironment _environment;
        private readonly string Connection = "";
        DBHelper DBHelper = new DBHelper();

        public HomeController(ILogger<HomeController> logger, IConfiguration configuration, IWebHostEnvironment hostEnvironment)
        {
            _logger = logger;
            _configuration = configuration;
            _environment = hostEnvironment;
            Connection = _configuration.GetConnectionString("constr").ToString();
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public JsonResult SortOrder(string numbers, bool IsAsc)
        {
            

            SortData srt = new SortData();
            DataTable data = new DataTable();
            bool sts = false;
            string msg = "Unsuccessfull";
            string[] array = numbers.Split(',');
            string Sortarray = "";
            try
            {
                var watch = System.Diagnostics.Stopwatch.StartNew();
                int[] myInts = Array.ConvertAll(array, int.Parse);
                //if (IsAsc == true)
                //{
                //    Array.Sort(myInts);
                //}
                //else
                //{
                //    Array.Sort(myInts);
                //    Array.Reverse(myInts);
                //}
                int n = myInts.Length;



                for (int i = 0; i < n; i++)   
                {
                    for (int j = i + 1; j < n; j++)
                    {
                        if (IsAsc == true)
                        {
                            if (myInts[i] > myInts[j])
                            {
                                int temp = myInts[i];
                                myInts[i] = myInts[j];
                                myInts[j] = temp;
                            }
                        }
                        if (IsAsc == false)
                        {
                            if (myInts[i] < myInts[j])
                            {
                                int temp = myInts[i];
                                myInts[i] = myInts[j];
                                myInts[j] = temp;
                            }

                        }
                    }
                }

                foreach (var item in myInts)
                {
                    Sortarray = Sortarray + (Sortarray == "" ? "" : ",") + item.ToString();
                }
                watch.Stop();
                srt.RequestSortNumber = numbers;
                srt.ResponseSortNumber = Sortarray;
                srt.SortingDirection = IsAsc == false ? "Desending" : "Ascending";
                srt.Timetaken = (watch.Elapsed.TotalSeconds).ToString() + " s";
                data = DBHelper.GetDateTableFromQuery("EXEC USP_AddSortData '" + DBHelper.ConvertToXML(srt) + "'", Connection);
                if (data.Rows.Count > 0)
                {
                    sts = Convert.ToBoolean(data.Rows[0]["Status"]);
                    msg = data.Rows[0]["Message"].ToString();
                }

            }
            catch (Exception ex)
            {
                msg = ex.Message;

            }   

            return Json(new { status = sts, message = msg, Sortedarray = Sortarray });
        }


        public IActionResult Export()
        {
            DataTable dt = new DataTable();
            dt = DBHelper.GetDateTableFromQuery("select * from Tbl_SortData", Connection);
            string jData = DBHelper.convertToJson(dt);
            
            var filepath = Path.Combine(_environment.WebRootPath, "Doc", "data.json");

            System.IO.File.WriteAllText(filepath, jData);

            return File(System.IO.File.ReadAllBytes(filepath), "image/png", System.IO.Path.GetFileName(filepath));
        }
    }
}
