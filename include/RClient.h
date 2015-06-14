
#include "axServer.h"
#include "axServerClient.h"
#include "axUtils.h"

namespace R
{
	class Client : public ax::Server::Client
	{
	public:
		Client(const std::string& ip_adress, const std::string& port);
	};
}