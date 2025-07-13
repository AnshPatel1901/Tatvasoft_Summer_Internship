using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mission.Entities.Models
{
    public class MissionViewModel
    {

        public int MissionId { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public string Theme { get; set; }

        public string SkillName { get; set; }

        public string StartDate { get; set; } // Use string if you format date as 'dd-MM-yyyy'

        public string EndDate { get; set; }

        public string Status { get; set; } // e.g. "Active", "Inactive"

    }
}
