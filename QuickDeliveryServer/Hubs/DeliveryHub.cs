using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;

namespace QuickDeliveryServer.Hubs
{
    public class DeliveryHub : Hub
    {
        public async Task UpdateOrderStatus(string orderId, string statusId)
        {
            IClientProxy proxy = Clients.Group(orderId);
            await proxy.SendAsync("UpdateOrderStatus", orderId, statusId);
        }

        public async Task UpdateDeliveryLocation(string [] orders, string latitude, string longitude)
        {
            foreach(string orderId in orders)
            {
                IClientProxy proxy = Clients.Group(orderId);
                await proxy.SendAsync("UpdateDeliveryLocation", latitude, longitude);
            }
        }

        public async Task OnConnect(string[] orders)
        {
            foreach (string orderId in orders)
                await Groups.AddToGroupAsync(Context.ConnectionId, orderId);
            await base.OnConnectedAsync();
        }

        public async Task OnDisconnect(string[] orders)
        {
            foreach (string orderId in orders)
                await Groups.RemoveFromGroupAsync(Context.ConnectionId, orderId);
            await base.OnDisconnectedAsync(null);
        }
    }
}
