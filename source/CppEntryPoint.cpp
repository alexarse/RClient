#include <iostream>
//#include <vector>
#include <string>
#include "axUtils.h"
#include "RClient.h"


struct KMeanInfo
{
	int nrow, ncol, nCluster;
};

extern "C"
{
	void ServerKMean(char** ip,
                     int* len_ip,
                     char** port,
                     int* len_port,
                     double* data,
                     int* nrow,
                     int* ncol,
                     int* nclust,
                     double* answer)
	{
		std::string server_ip(*ip, *len_ip);
		std::string server_port(*port, *len_port);

		R::Client client(server_ip, server_port);

		int sockfd = client.GetSocketFd();

        // Setup kmeans info.
		KMeanInfo kmean_info;
		kmean_info.nrow = *nrow;
		kmean_info.ncol = *ncol;
		kmean_info.nCluster = *nclust;
        
        // Send kmeans info.
		int bytes = ax::Server::Send<KMeanInfo>(sockfd, kmean_info);

        // Send kmeans data.
		bytes = ax::Server::Send<double>(sockfd,
                                         data,
                                         sizeof(double) * *nrow * *ncol);

        // Receive kmeans answer.
		const int totalByteToReceive = sizeof(double) * *ncol * *nclust;

		bytes = ax::Server::Receive<double>(sockfd, 
											answer,
											totalByteToReceive);

		// unsigned char* raw_bytes = new unsigned char[totalByteToReceive];

		// int total_bytes_receive = 0;

		// do
		// {
		// 	int bytes_left = totalByteToReceive - total_bytes_receive;
			
		// 	unsigned char* raw_buffer = raw_bytes + total_bytes_receive;
		// 	int bytes = ax::Server::Receive<unsigned char>(sockfd,
  //                                                          raw_buffer,
  //                                                          bytes_left);
			
		// 	total_bytes_receive += bytes;

		// } while(total_bytes_receive < totalByteToReceive);

        // Copy kmeans answer in answer buffer.
//		double* ans = (double*)raw_bytes;

        // std::size_t size_to_copy = totalByteToReceive;
        // std::memcpy((void*)answer, (const void*)raw_bytes, size_to_copy);
        
//		for(int i = 0; i < *ncol * *nclust; i++)
//		{
//			answer[i] = ans[i];
//		}

		// delete[] raw_bytes;
	}
}
