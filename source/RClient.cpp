#include "RClient.h"


namespace R
{
	Client::Client(const std::string& ip_adress, const std::string& port):
	ax::Server::Client(ip_adress, port)
	{

	}
}
