using Client.Api.Models;
using Dapper;
using System;
using System.Collections.Generic;

namespace Client.Api.Services
{
    public class ContactService
    {
        public List<Contact> GetContacts()
        {
            List<Contact> contacts = DBAccessService.GetMultipleResults<Contact>("spContact_Get", null);
            return contacts;
        }
        public Contact GetContactById(int contactId)
        {
            var parameter = new DynamicParameters();
            parameter.Add("Id", contactId);
            Contact contact = DBAccessService.GetSingleResult<Contact>("spContact_GetById", parameter);
            return contact;
        }
        public int SaveContact(Contact contact)
        {
            var parameter = new DynamicParameters();
            parameter.Add("Id", Convert.ToInt32(contact.Id));
            parameter.Add("FirstName", contact.FirstName);
            parameter.Add("LastName", contact.LastName);
            parameter.Add("Email", contact.Email);
            parameter.Add("PhoneNumber", contact.PhoneNumber);
            parameter.Add("IsActive", contact.Status);
            return DBAccessService.Execute("spContact_Upsert", parameter);
        }
        public int DeleteContactById(int contactId)
        {
            var parameter = new DynamicParameters();
            parameter.Add("Id", contactId);
            Contact contact = DBAccessService.GetSingleResult<Contact>("spContact_GetById", parameter);
            return DBAccessService.Execute("spContact_DeleteById", parameter);
        }
    }
}