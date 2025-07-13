using Mission.Entities.Entities;
using Mission.Repositories.IRepositories;
using Mission.Services.IServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mission.Services.Services
{
    public class MissionService : IMissionService
    {

        private readonly IMissionRepository _missionRepo;

        public MissionService(IMissionRepository missionRepo)
        {
            _missionRepo = missionRepo;
        }

        public Task<IEnumerable<MissionEntity>> GetAllMissionsAsync()
            => _missionRepo.GetAllMissionsAsync();

        public Task<MissionEntity?> GetMissionByIdAsync(int id)
            => _missionRepo.GetMissionByIdAsync(id);

        public Task AddMissionAsync(MissionEntity mission)
            => _missionRepo.AddMissionAsync(mission);

        public Task UpdateMissionAsync(MissionEntity mission)
            => _missionRepo.UpdateMissionAsync(mission);

        public Task DeleteMissionAsync(int id)
            => _missionRepo.DeleteMissionAsync(id);
    }
}

