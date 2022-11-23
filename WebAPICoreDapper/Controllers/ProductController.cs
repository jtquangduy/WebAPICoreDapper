﻿using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Localization;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using WebAPICoreDapper.Dtos;
using WebAPICoreDapper.Extensions;
using WebAPICoreDapper.Filters;
using WebAPICoreDapper.Models;
using WebAPICoreDapper.Resources;

namespace WebAPICoreDapper.Controllers
{
    [Route("api/{culture}/[controller]")]
    [ApiController]
    [MiddlewareFilter(typeof(LocalizationPipeline))]
    public class ProductController : ControllerBase
    {
        private readonly string _connectionString;
        private readonly ILogger<ProductController> _logger;
        private readonly IStringLocalizer<ProductController> _localizer;
        private readonly LocService _locService;

        public ProductController(IConfiguration configuration, ILogger<ProductController> logger, LocService locService, IStringLocalizer<ProductController> localizer)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
            _logger = logger;
            _locService = locService;
            _localizer = localizer;
        }

        // GET: api/Product
        [HttpGet]
        public async Task<IEnumerable<Product>> Get()
        {
            //string text = _localizer["Test"];
            //string text1 = _locService.GetLocalizedHtmlString("ForgotPassword");
            _logger.LogError("Test product controller");

            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();

                var parameters = new DynamicParameters();
                parameters.Add("@language", CultureInfo.CurrentCulture.Name);

                var result = await conn.QueryAsync<Product>("Get_Product_All", parameters, null, null, CommandType.StoredProcedure);

                return result;
            }
        }

        // GET: api/Product/5
        [HttpGet("{id}", Name = "Get")]
        public async Task<Product> Get(int id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();

                var parameters = new DynamicParameters();
                parameters.Add("@id", id);
                parameters.Add("@language", CultureInfo.CurrentCulture.Name);


                var result = await conn.QueryAsync<Product>("Get_Product_By_Id", parameters, null, null, CommandType.StoredProcedure);

                return result.Single();
            }
        }

        [HttpGet("paging", Name = "GetPaging")]
        public async Task<PagedResult<Product>> GetPaging(string keyword, int categoryId, int pageIndex, int pageSize)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();

                var parameters = new DynamicParameters();
                parameters.Add("@keyword", keyword);
                parameters.Add("@categoryId", categoryId);
                parameters.Add("@pageIndex", pageIndex);
                parameters.Add("@pageSize", pageSize);
                parameters.Add("@language", CultureInfo.CurrentCulture.Name);
                parameters.Add("@totalRow", dbType: DbType.Int32, direction: ParameterDirection.Output);

                var result = await conn.QueryAsync<Product>("Get_Product_AllPaging", parameters, null, null, CommandType.StoredProcedure);

                int totalRow = parameters.Get<int>("@totalRow");

                var pagedResult = new PagedResult<Product>()
                {
                    Items = result.ToList(),
                    TotalRow = totalRow,
                    PageIndex = pageIndex,
                    PageSize = pageSize
                };

                return pagedResult;
            }
        }

        // POST: api/Product
        [HttpPost]
        [ValidateModel]
        public async Task<IActionResult> Post([FromBody] Product product)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();

                var parameters = new DynamicParameters();
                parameters.Add("@name", product.Name);
                parameters.Add("@description", product.Description);
                parameters.Add("@content", product.Content);
                parameters.Add("@seoDescription", product.SeoDescription);
                parameters.Add("@seoAlias", product.SeoAlias);
                parameters.Add("@seoTitle", product.SeoTitle);
                parameters.Add("@seoKeyword", product.SeoKeyword);
                parameters.Add("@sku", product.Sku);
                parameters.Add("@price", product.Price);
                parameters.Add("@isActive", product.IsActive);
                parameters.Add("@imageUrl", product.ImageUrl);
                parameters.Add("@language", CultureInfo.CurrentCulture.Name);
                parameters.Add("@id", dbType: DbType.Int32, direction: ParameterDirection.Output);

                var result = await conn.ExecuteAsync("Create_Product", parameters, null, null, CommandType.StoredProcedure);

                int newId = parameters.Get<int>("@id");

                return Ok(newId);
            }
        }

        // PUT: api/Product/5
        [HttpPut("{id}")]
        [ValidateModel]
        public async Task<IActionResult> Put(int id, [FromBody] Product product)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();

                var parameters = new DynamicParameters();
                parameters.Add("@id", id);
                parameters.Add("@name", product.Name);
                parameters.Add("@description", product.Description);
                parameters.Add("@content", product.Content);
                parameters.Add("@seoDescription", product.SeoDescription);
                parameters.Add("@seoAlias", product.SeoAlias);
                parameters.Add("@seoTitle", product.SeoTitle);
                parameters.Add("@seoKeyword", product.SeoKeyword);
                parameters.Add("@sku", product.Sku);
                parameters.Add("@price", product.Price);
                parameters.Add("@isActive", product.IsActive);
                parameters.Add("@imageUrl", product.ImageUrl);
                parameters.Add("@language", CultureInfo.CurrentCulture.Name);

                await conn.ExecuteAsync("Update_Product", parameters, null, null, CommandType.StoredProcedure);

                return Ok();
            }
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public async Task Delete(int id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();

                var parameters = new DynamicParameters();
                parameters.Add("@id", id);

                await conn.ExecuteAsync("Delete_Product_By_Id", parameters, null, null, CommandType.StoredProcedure);
            }
        }
    }
}