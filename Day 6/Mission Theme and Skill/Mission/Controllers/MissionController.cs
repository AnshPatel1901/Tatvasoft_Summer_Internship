using Microsoft.AspNetCore.Mvc;
using Mission.Entities;
using Mission.Entities.Entities;
using Mission.Entities.Models;
using Mission.Services.IServices;

namespace Mission.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MissionController(IMissionService missionService) : ControllerBase
    {
        private readonly IMissionService _missionService = missionService;

        [HttpGet]
        [Route("GetMissionList")]
        public async Task<IActionResult> GetAllMissions()
        {
            try
            {
                var res = await _missionService.GetAllMissionsAsync();
                return Ok(new ResponseResult
                {
                    Data = res,
                    Result = ResponseStatus.Success,
                    Message = ""
                });
            }
            catch
            {
                return BadRequest(new ResponseResult
                {
                    Data = null,
                    Result = ResponseStatus.Error,
                    Message = "Failed to get mission list"
                });
            }
        }

        [HttpGet]
        [Route("GetMissionById/{id:int}")]
        public async Task<IActionResult> GetMissionById(int id)
        {
            var res = await _missionService.GetMissionByIdAsync(id);

            if (res == null)
                return NotFound(new ResponseResult
                {
                    Data = null,
                    Result = ResponseStatus.Error,
                    Message = "Mission not found"
                });

            return Ok(new ResponseResult
            {
                Data = res,
                Result = ResponseStatus.Success,
                Message = ""
            });
        }

        [HttpPost]
        [Route("AddMission")]
        public async Task<IActionResult> AddMission([FromBody] MissionViewModel vm)
        {
            try
            {
                var entity = new MissionEntity
                {
                    MissionId = vm.MissionId,
                    Title = vm.Title,
                    Description = vm.Description,
                    Theme = vm.Theme,
                    Skill = vm.SkillName,
                    StartDate = DateTime.Parse(vm.StartDate),
                    EndDate = DateTime.Parse(vm.EndDate),
                    //Status = vm.Status
                };

                await _missionService.AddMissionAsync(entity);

                return Ok(new ResponseResult
                {
                    Data = vm,
                    Result = ResponseStatus.Success,
                    Message = "Mission added successfully"
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseResult
                {
                    Data = null,
                    Result = ResponseStatus.Error,
                    Message = $"Failed to add mission: {ex.Message}"
                });
            }
        }

        [HttpPut]
        [Route("UpdateMission")]
        public async Task<IActionResult> UpdateMission([FromBody] MissionViewModel vm)
        {
            try
            {
                var entity = new MissionEntity
                {
                    MissionId = vm.MissionId,
                    Title = vm.Title,
                    Description = vm.Description,
                    Theme = vm.Theme,
                    Skill = vm.SkillName,
                    StartDate = DateTime.Parse(vm.StartDate),
                    EndDate = DateTime.Parse(vm.EndDate),
                    //Status = vm.Status
                };

                await _missionService.UpdateMissionAsync(entity);

                return Ok(new ResponseResult
                {
                    Data = vm,
                    Result = ResponseStatus.Success,
                    Message = "Mission updated successfully"
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new ResponseResult
                {
                    Data = null,
                    Result = ResponseStatus.Error,
                    Message = $"Failed to update mission: {ex.Message}"
                });
            }
        }

        [HttpDelete]
        [Route("DeleteMission/{id:int}")]
        public async Task<IActionResult> DeleteMission(int id)
        {
            var entity = await _missionService.GetMissionByIdAsync(id);

            if (entity == null)
                return NotFound(new ResponseResult
                {
                    Data = null,
                    Result = ResponseStatus.Error,
                    Message = "Mission not found"
                });

            await _missionService.DeleteMissionAsync(id);

            return Ok(new ResponseResult
            {
                Data = null,
                Result = ResponseStatus.Success,
                Message = "Mission deleted successfully"
            });
        }
    }
}
