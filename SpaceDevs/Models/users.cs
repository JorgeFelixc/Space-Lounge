using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpaceDevs.Models
{
    public class users
    {
        [BsonId]
        public ObjectId _id { get; set; }
        public string usuario { get; set; }
        public string password { get; set; }
    }
}