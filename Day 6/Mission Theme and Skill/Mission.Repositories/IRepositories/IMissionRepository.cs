using Mission.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mission.Repositories.IRepositories
{
    public interface IMissionRepository
    {

        Task<IEnumerable<MissionEntity>> GetAllMissionsAsync();
        Task<MissionEntity?> GetMissionByIdAsync(int id);
        Task AddMissionAsync(MissionEntity mission);
        Task UpdateMissionAsync(MissionEntity mission);
        Task DeleteMissionAsync(int id);

    }
}
