
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace Prueba
{
    internal class Program
    {
        public static string apikey = "xDkruimtb6zz0kKM0QgnU1F1MURNGg72dbuWEfol";
        static void Main(string[] args)
        {
            string opc;
            do
            {
                Console.ForegroundColor = ConsoleColor.Yellow;
                Console.WriteLine("1. Para agregar inmueble");
                Console.WriteLine("2. Para consultar un inmueble por id");
                Console.WriteLine("3. Para consultar amenities por tipo de inmueble");
                Console.WriteLine("4. Para consultar tipo de inmueble");
                Console.WriteLine("5. Para consultar tipo de negocio");
                Console.WriteLine("6. Para consultar regiones");
                Console.WriteLine("7. Para consultar ciudades");
                Console.WriteLine("0. Para salir");
                opc = Console.ReadLine();
                if (opc == "1")
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                    PublishProperties().Wait(); // Esperar a que la tarea se complete
                }
                else if (opc == "2")
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                    PropertyId().Wait();
                }
                else if (opc == "3")
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                    AmenitiRequest().Wait();
                }
                else if (opc == "4")
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                    TypeProperties().Wait();
                }
                else if (opc == "5")
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                    BusinessType().Wait();
                }
                else if (opc == "6")
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                    RequestRegions().Wait();
                }
                else if (opc == "7")
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                    RequestCitys().Wait();
                }

                Console.WriteLine("Presiona enter para continuar...");
                Console.ReadKey();
                Console.Clear();
            } while (opc!="0");
            
        }

        static async Task<string> TokenRequest(HttpClient client)
        {
            string url = "https://ptec-core-dev-third-party-apis.metrocuadrado.com/v1/api/core/oauth2/tokens";

            var parametros = new Dictionary<string, string>
            {
                { "identification", "860006773" },
                { "username", "cavipetrol" },
                { "password", "p0P0C9*S" }
            };
            string json = JsonSerializer.Serialize(parametros);
            HttpContent content = new StringContent(json, Encoding.UTF8, "application/json");
            HttpResponseMessage response = await client.PostAsync(url, content);
            if (response.IsSuccessStatusCode)
            {
                var jsonToken = await response.Content.ReadAsStringAsync();
                // Parsear el JSON
                JObject objetoJson = JObject.Parse(jsonToken);

                // Obtener el valor de access_token
                string accessToken = objetoJson["data"]["access_token"].ToString();
                return accessToken;
            }
            else
            {
                return "error: " + response.StatusCode;
            }
        }

        static async Task PropertyId()
        {
            var client = new HttpClient();
            string token = await TokenRequest(client);
            string propertyId = "223-11738"; //Variable hay que dejarla dinamica de acuerdo a los inmuebles del usuario, cambiarlo a parametro
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Get,
                RequestUri = new Uri("https://ptec-core-dev.metrocuadrado.com/rest-api/realestate/" + propertyId),
                Headers =
                {
                    { "token", token },
                    { "x-api-key", apikey },
                    { "Accept", "application/json, application/xml" },
                },

            };
            using (var response = await client.SendAsync(request))
            {
                response.EnsureSuccessStatusCode();
                var body = await response.Content.ReadAsStringAsync();
                Console.WriteLine(body);
            }
        }

        static async Task AmenitiRequest()
        {
            var client = new HttpClient();
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Get,
                RequestUri = new Uri("https://ptec-core-dev.metrocuadrado.com/rest-catalogue/amenities/?realEstateType=1"),
                Headers =
                {
                    { "x-api-key", apikey },
                    { "Accept", "application/json, application/xml" },
                },
            };

            using (var response = await client.SendAsync(request))
            {
                response.EnsureSuccessStatusCode();
                var body = await response.Content.ReadAsStringAsync();
                Console.WriteLine(body);
            }
        }

        static async Task PublishProperties()
        {
            var client = new HttpClient();
            string token = await TokenRequest(client);
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Post,
                RequestUri = new Uri("https://ptec-core-dev.metrocuadrado.com/rest-api/realestate/publish"),
                Headers =
                {
                    { "token", token },
                    { "x-api-key", apikey },
                    { "Accept", "application/json, application/xml" },
                },
                Content = new StringContent("{\n \"realEstateType\": 1,\n \"realEstateOffer\": 2,\n \"price\": 9000000,\n \"city\": 1,\n \"administration\": 1000000,\n \"images\": [\n \"https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.adsttc.com%2Fmedia%2Fimages%2F623c%2F4fa0%2F3e4b%2F3145%2F3000%2F001b%2Fnewsletter%2F_d_ambrosio_07._copy.jpg%3F1648119692&tbnid=F4rilGwvuA4gPM&vet=12ahUKEwiCgOG4k4yAAxU8k4kEHTorBS4QMygAegUIARDrAQ..i&imgrefurl=https%3A%2F%2Fwww.archdaily.co%2Fco%2F979044%2Fcasa-de-casas-yuso&docid=FtYMOH-_Dk9qHM&w=750&h=656&q=casas&hl=es&ved=2ahUKEwiCgOG4k4yAAxU8k4kEHTorBS4QMygAegUIARDrAQ%22\"\n ],\n \"comments\": \"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum\",\n \"stratum\": 2,\n \"address\": \"TV 77 I 71 A 63 SUR\",\n \"neighborhood\": \"JOSE MARIA CARBONEL\",\n \"agentId\": 340716,\n \"latitude\": 4.60059,\n \"longitude\": -74.19626,\n \"video\": \"https://www.youtube.com/watch?v=xFBs6CUrSKU\",\n \"responseUrl\": \"https://5kpfbdi70i.execute-api.us-east-1.amazonaws.com/default/callback-express\",\n \"amenities\": {\"view\":\"Interior\",\r\n\r\n            \"builtTime\":\"Más de 20 años\",\r\n\r\n            \"rooms\":\"5\",\r\n\r\n            \"bathrooms\":\"5\",\r\n\r\n            \"garages\":\"4\",\r\n\r\n            \"block\":\"b102\",\r\n\r\n            \"garageType\":\"Independiente\",\r\n\r\n            \"block string\":\"true\",\r\n\r\n            \"builtArea\":\"100\",\r\n\r\n            \"area\":\"96\",\r\n\r\n            \"lotArea\":\"95\",\r\n\r\n            \"negotiable\":\"true\",\r\n\r\n            \"width\":\"1\",\r\n\r\n            \"depth\":\"1\",\r\n\r\n            \"kitchenForm\":\"Paralela\",\r\n\r\n            \"dinningRoomType\":\"Comedor Independiente\",\r\n\r\n            \"gasInstallationType\":\"Natural\",\r\n\r\n            \"stoveType\":\"Electrica\",\r\n\r\n            \"heaterType\":\"No tiene\",\r\n\r\n            \"studyOrLibrary\":\"true\",\r\n\r\n            \"terraceOrBalcony\":\"Terraza\",\r\n\r\n            \"terraceOrBalconyArea\":\"9999999.99\",\r\n\r\n            \"closedComplex\":\"true\",\r\n\r\n            \"laundryArea\":\"true\",\r\n\r\n            \"furnished\":\"true\",\r\n\r\n            \"curtainType\":\"Ninguna\",\r\n\r\n            \"floorNumber\":\"55\",\r\n\r\n            \"serviceRoom\":\"true\",\r\n\r\n            \"auxiliaryDinningRoom\":\"true\",\r\n\r\n            \"chimney\":\"true\",\r\n\r\n            \"airConditioned\":\"true\",\r\n\r\n            \"bedroomFlooringType\":\"Laminado\",\r\n\r\n            \"studyFlooringType\":\"Laminado\",\r\n\r\n            \"diningRoomFlooringType\":\"Laminado\",\r\n\r\n            \"livingRoomFlooringType\":\"Laminado\",\r\n\r\n            \"cytophone\":\"true\",\r\n\r\n            \"practiceNumber\":\"b203\",\r\n\r\n            \"officeType\":\"Casa\",\r\n\r\n            \"officeNumber\":\"B202\",\r\n\r\n            \"apartmentNumber\":\"202\",\r\n\r\n            \"smartOffices\":\"true\",\r\n\r\n            \"flooringType\":\"Laminado\",\r\n\r\n            \"wardrobes\":\"4\",\r\n\r\n            \"phoneLines\":\"4\",\r\n\r\n            \"mortgageEntity\":\"Colmena BCSC\",\r\n\r\n            \"houseType\":\"Tradicional\",\r\n\r\n            \"lifts\":\"4\",\r\n\r\n            \"registrationNumber\":\"F304\",\r\n\r\n            \"hall\":\"true\",\r\n\r\n            \"jacuzzi\":\"true\",\r\n\r\n            \"securityDoors\":\"true\",\r\n\r\n            \"alarm\":\"true\",\r\n\r\n            \"bodyguardRoom\":\"true\",\r\n\r\n            \"panoramicView\":\"true\",\r\n\r\n            \"pool\":\"true\",\r\n\r\n            \"tennisCourt\":\"true\",\r\n\r\n            \"squashCourt\":\"true\",\r\n\r\n            \"basketballCourt\":\"true\",\r\n\r\n            \"soccerField\":\"true\",\r\n\r\n            \"sauna\":\"true\",\r\n\r\n            \"elevator\":\"true\",\r\n\r\n            \"corner\":\"true\",\r\n\r\n            \"lotType\":\"Lote vacío\",\r\n\r\n            \"clinicType\":\"Laboratorio\",\r\n\r\n            \"establishmentNumber\":\"302\",\r\n\r\n            \"establishmentType\":\"Otro\",\r\n\r\n            \"estateType\":\"Finca de recreo\",\r\n\r\n            \"warehouseType\":\"Otro\",\r\n\r\n            \"warehouseNumber\":\"B103\",\r\n\r\n            \"hasOffices\":\"true\",\r\n\r\n            \"buildingRating\":\"Edificio inteligente\",\r\n\r\n            \"rentalPeriod\":\"Meses\",\r\n\r\n            \"levels\":\"4\",\r\n\r\n            \"heater\":\"true\",\r\n\r\n            \"handicappedAccesible\":\"true\",\r\n\r\n            \"greenArea\":\"true\",\r\n\r\n            \"childrenArea\":\"true\",\r\n\r\n            \"cctv\":\"true\",\r\n\r\n            \"bbqArea\":\"true\",\r\n\r\n            \"fireAlarm\":\"true\",\r\n\r\n            \"innerGarden\":\"true\",\r\n\r\n            \"communityHall\":\"true\",\r\n\r\n            \"deposits\":\"3\",\r\n\r\n            \"coveredGarage\":\"true\",\r\n\r\n            \"pedestrianWalkway\":\"true\",\r\n\r\n            \"garden\":\"true\",\r\n\r\n            \"gym\":\"true\",\r\n\r\n            \"surveillanceType\":\"12hrs\",\r\n\r\n            \"petsAllowed\":\"true\",\r\n\r\n            \"clinics\":\"true\",\r\n\r\n            \"onMainStreet\":\"true\",\r\n\r\n            \"onSecondaryRoad\":\"true\",\r\n\r\n            \"smokingAllowed\":\"true\",\r\n\r\n            \"nearbySupermarket\":\"true\",\r\n\r\n            \"nearbyShoppingCenter\":\"true\",\r\n\r\n            \"nearbyPark\":\"true\",\r\n\r\n            \"nearbyPublicTransport\":\"true\",\r\n\r\n            \"nearbySchoolCollege\":\"true\",\r\n\r\n            \"kitchenette\":\"true\",\r\n\r\n            \"woodenFloor\":\"true\",\r\n\r\n            \"carpetedFloor\":\"true\",\r\n\r\n            \"tiledFloor\":\"true\",\r\n\r\n            \"porcelainTiledFloor\":\"true\",\r\n\r\n            \"fullKitchen\":\"true\",\r\n\r\n            \"americanKitchen\":\"true\",\r\n\r\n            \"serviceBathroom\":\"true\",\r\n\r\n            \"visitorParkingLot\":\"true\",\r\n\r\n            \"terrace\":\"true\",\r\n\r\n            \"ravineBoundary\":\"true\",\r\n\r\n            \"courtyard\":\"true\",\r\n\r\n            \"electricPlant\":\"true\",\r\n\r\n            \"utilityRoom\":\"true\",\r\n\r\n            \"golfCage\":\"true\",\r\n\r\n            \"waterTank\":\"true\",\r\n\r\n            \"twoFamilyHome\":\"true\",\r\n\r\n            \"truckAccess\":\"true\",\r\n\r\n            \"unobstructedHeight\":\"true\",\r\n\r\n            \"restrictedHeight\":\"true\",\r\n\r\n            \"countryside\":\"true\",\r\n\r\n            \"urbanArea\":\"true\",\r\n\r\n            \"auxiliaryBathroom\":\"true\",\r\n\r\n            \"trailerDoor\":\"true\",\r\n\r\n            \"surveillance\":\"true\",\r\n\r\n            \"publicBathroom\":\"true\",\r\n\r\n            \"fuelPump\":\"true\",\r\n\r\n            \"parkingType\":\"Exterior\",\r\n\r\n            \"withHouse\":\"true\",\r\n\r\n            \"emptyLot\":\"true\",\r\n\r\n            \"administrativeOffices\":\"true\",\r\n\r\n            \"gateHouse\":\"true\",\r\n\r\n            \"restaurants\":\"true\",\r\n\r\n            \"inShoppingCenter\":\"true\",\r\n\r\n            \"inBuilding\":\"true\",\r\n\r\n            \"ruralZone\":\"true\",\r\n\r\n            \"shoppingZone\":\"true\",\r\n\r\n            \"industrialZone\":\"true\",\r\n\r\n            \"residentialZone\":\"true\"}\n}")
                {
                    Headers =
                    {
                        ContentType = new MediaTypeHeaderValue("application/json")
                    }
                }
            };
            using (var response = await client.SendAsync(request))
            {
                response.EnsureSuccessStatusCode();
                var body = await response.Content.ReadAsStringAsync();
                Console.WriteLine(body);
            }

        }

        static async Task TypeProperties()
        {
            var client = new HttpClient();
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Get,
                RequestUri = new Uri("https://ptec-core-dev.metrocuadrado.com/rest-catalogue/realestatetypes/"),
                Headers =
                {
                    { "x-api-key", apikey },
                    { "Accept", "application/json, application/xml" },
                },
            };

            using (var response = await client.SendAsync(request))
            {
                response.EnsureSuccessStatusCode();
                var body = await response.Content.ReadAsStringAsync();
                Console.WriteLine(body);
            }
        }

        static async Task BusinessType()
        {
            var client = new HttpClient();
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Get,
                RequestUri = new Uri("https://ptec-core-dev.metrocuadrado.com/rest-catalogue/businesstypes/"),
                Headers =
                {
                    { "x-api-key", apikey },
                    { "Accept", "application/json, application/xml" },
                },
            };

            using (var response = await client.SendAsync(request))
            {
                response.EnsureSuccessStatusCode();
                var body = await response.Content.ReadAsStringAsync();
                Console.WriteLine(body);
            }
        }

        static async Task RequestRegions()
        {
            var client = new HttpClient();
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Get,
                RequestUri = new Uri("https://ptec-core-dev.metrocuadrado.com/rest-catalogue/regions/"),
                Headers =
                {
                    { "x-api-key", apikey },
                    { "Accept", "application/json, application/xml" },
                },
            };
            using (var response = await client.SendAsync(request))
            {
                response.EnsureSuccessStatusCode();
                var body = await response.Content.ReadAsStringAsync();
                Console.WriteLine(body);
            }
        }

        static async Task RequestCitys()
        {
            var client = new HttpClient();
            var request = new HttpRequestMessage
            {
                Method = HttpMethod.Get,
                RequestUri = new Uri("https://ptec-core-dev.metrocuadrado.com/rest-catalogue/cities/?regionId=14"),
                Headers =
                {
                    { "x-api-key", apikey },
                    { "Accept", "application/json, application/xml" },
                },
            };
            using (var response = await client.SendAsync(request))
            {
                response.EnsureSuccessStatusCode();
                var body = await response.Content.ReadAsStringAsync();
                Console.WriteLine(body);
            }
        }
    }
}