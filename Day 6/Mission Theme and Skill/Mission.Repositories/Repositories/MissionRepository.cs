using Microsoft.EntityFrameworkCore;
using Mission.Entities.Context;
using Mission.Entities.Entities;
using Mission.Repositories.IRepositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mission.Repositories.Repositories
{
    public class MissionRepository : IMissionRepository
    {
            private readonly MissionDbContext _context;

            public MissionRepository(MissionDbContext context)
            {
                _context = context;
            }

            public async Task<IEnumerable<MissionEntity>> GetAllMissionsAsync()
            {
                return await _context.MissionEntities.ToListAsync();
            }

            public async Task<MissionEntity?> GetMissionByIdAsync(int id)
            {
                return await _context.MissionEntities.FindAsync(id);
            }

            public async Task AddMissionAsync(MissionEntity mission)
            {
                await _context.MissionEntities.AddAsync(mission);
                await _context.SaveChangesAsync();
            }

            public async Task UpdateMissionAsync(MissionEntity mission)
            {
                _context.MissionEntities.Update(mission);
                await _context.SaveChangesAsync();
            }

            public async Task DeleteMissionAsync(int id)
            {
                var mission = await _context.MissionEntities.FindAsync(id);
                if (mission != null)
                {
                    _context.MissionEntities.Remove(mission);
                    await _context.SaveChangesAsync();
                }
            }
        }
    }


