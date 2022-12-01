namespace Test.Services;
using System.Globalization;
using System.Net.Http.Headers;
using System.Text.Json;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Mvc.Rendering;

public class BaseService {
    public TestModels db;
    public HttpContext _hca;
    public IWebHostEnvironment _env;

    public BaseService(string model_type = "", string action_type = "", int edit_id = 0, int second_id = 0, string report_type = "", HttpContext hca = null, IWebHostEnvironment env = null) {
        db = new TestModels(GetRoot(), IsProd());
    }

    public string GetRoot() {
        return _env.ContentRootPath;
    }

    public bool IsProd() {
        return false;
    }

}
