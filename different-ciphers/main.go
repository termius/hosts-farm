package main

import (
	"log"
	"net"

	"golang.org/x/crypto/ssh"
)

func main() {
	serverCiphers := []string{"chacha20-poly1305@openssh.com"}
	clientCiphers := []string{"aes256-ctr"}

	serverConfig := &ssh.ServerConfig{
		Config: ssh.Config{
			Ciphers: append(serverCiphers, clientCiphers...),
		},
		NoClientAuth: true,
	}

	privateKey := []byte(`-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACCzJN83JokBDTHc/61cXxbrhYiYlSHM2b+KLaua/oCOFwAAAKggA7TiIAO0
4gAAAAtzc2gtZWQyNTUxOQAAACCzJN83JokBDTHc/61cXxbrhYiYlSHM2b+KLaua/oCOFw
AAAEAviqTJ87JMIBi+AaA7Ha/XkUwZkrsJ5ikUGPhjogtvubMk3zcmiQENMdz/rVxfFuuF
iJiVIczZv4otq5r+gI4XAAAAIW5kekBDcnlzdGFsbml4cy1NYWNCb29rLUFpci5sb2NhbA
ECAwQ=
-----END OPENSSH PRIVATE KEY-----`)

	signer, err := ssh.ParsePrivateKey(privateKey)
	if err != nil {
		log.Fatalf("Failed to parse private key: %v", err)
	}

	serverConfig.AddHostKey(signer)

	listener, err := net.Listen("tcp", "0.0.0.0:2022")
	if err != nil {
		log.Fatalf("Failed to listen on 2022: %v", err)
	}

	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Fatalf("Failed to accept connection: %v", err)
		}

		go func(conn net.Conn) {
			defer conn.Close()

			_, chans, _, err := ssh.NewServerConn(conn, serverConfig)
			if err != nil {
				log.Printf("Failed to handshake: %v", err)
				return
			}

			for newChannel := range chans {
				go handleChannel(newChannel)
			}
		}(conn)
	}
}

func handleChannel(newChannel ssh.NewChannel) {
	channel, requests, err := newChannel.Accept()
	if err != nil {
		log.Printf("Could not accept channel: %v", err)
		return
	}
	defer channel.Close()

	for req := range requests {
		if req.Type == "shell" {
			req.Reply(true, nil)
			break
		}
	}
}
