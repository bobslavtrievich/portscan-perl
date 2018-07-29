#!/usr/bin/perl

# coded by: Bob Slavtrievich
# GitHub: github.com/bobslavtrievich

use IO::Socket;
$| = 1;

print "\n [!] Digite o host: ";
chop ($host = <stdin>);

$porta = 1;

print "\n [!] Iniciando scan em: $host\n\n";

foreach ($porta ; $porta < 65536 ; $porta++) {

   while (1) {
      ( $serv_TCP ) = getservbyport($porta , "tcp");
      ( $serv_UDP ) = getservbyport($porta , "udp");

      if ( $serv_TCP ){
         $serv = $serv_TCP." | TCP";
         last;
      }
      elsif ( $serv_UDP ){
         $serv = $serv_UDP." | UDP";
         last;
      } else {
         $porta++;
      }
   }

   print " [*] Escaneando porta: $porta | $serv        \r";

   $socket = IO::Socket::INET->new(PeerAddr => $host , PeerPort => $porta ,  Proto => 'tcp',Timeout => 1.5);

   if( $socket ){
      print "\r [*] Porta: $porta ~> $serv [aberta]        \n" ;
   }


}

exit (0);
