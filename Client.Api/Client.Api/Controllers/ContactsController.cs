using Client.Api.Models;
using Client.Api.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Client.Api.Controllers
{
    public class ContactsController : ApiController
    {
        [Route("contacts")]
        [HttpGet]
        public HttpResponseMessage GetContacts()
        {
            ContactService contactService = new ContactService();
            var contacts = contactService.GetContacts();
            return Request.CreateResponse(HttpStatusCode.OK, contacts);
        }

        [Route("contacts/{id}/details")]
        [HttpGet]
        public HttpResponseMessage GetContacts([FromUri] int id)
        {
            if ( id == 0 )
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,"Invalid Contact Id");
            }
            ContactService contactService = new ContactService();
            var contacts = contactService.GetContactById(id);
            return Request.CreateResponse(HttpStatusCode.OK, contacts);
        }

        [Route("contacts/upsert")]
        [HttpPost]
        public HttpResponseMessage UpsertContact(Contact contact )
        {
            if (contact == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, "Invalid Request");
            }
            ContactService contactService = new ContactService();
            int result = contactService.SaveContact(contact);
            return Request.CreateResponse(result > 0 ? HttpStatusCode.OK : HttpStatusCode.InternalServerError, result);
        }

        [Route("contacts/{id}")]
        [HttpDelete]
        public HttpResponseMessage DeleteContact([FromUri] int id)
        {
            if (id == 0)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, "Invalid Contact Id");
            }
            ContactService contactService = new ContactService();
            int result = contactService.DeleteContactById(id);
            return Request.CreateResponse(result > 0 ? HttpStatusCode.OK : HttpStatusCode.InternalServerError, result);
        }
    }
}
