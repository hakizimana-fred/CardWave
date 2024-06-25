import { SERVICES } from "@/data";
import { ArrowRight } from "lucide-react";
import { useEffect, useState } from "react";
import { useAccount, useBalance } from "wagmi";

export default function Home() {
    const [userAddress, setUserAddress] = useState("");
    const [isMounted, setIsMounted] = useState(false);
    const { address, isConnected } = useAccount();

      const { data, isError, isLoading } = useBalance({
        address,
        unit: 'ether'
    })

    useEffect(() => {
        setIsMounted(true);
    }, []);

    useEffect(() => {
        if (isConnected && address) {
            setUserAddress(address);
        }
    }, [address, isConnected]);

    if (!isMounted) {
        return null;
    }

    return (
        <div className="wrapper">
        <div className="balance-wrapper">
            {isConnected ? (
                <>
                <h1>Your Wallet</h1>
                <div className="h2 text-center">
                    balance: ${data?.formatted as any} 
                </div>

                <div className="h2 text-center">
                    address: {userAddress}
                </div>
                </>

            ) : (
                <div>Please connect your wallet to get started</div>
            )}
        </div>
        <div className="cards-wrapper">
            <div style={{display: 'flex', justifyContent: 'space-between', alignItems: 'center'}}>
                <h1>Redeem gift cards</h1>
                <ArrowRight color="#000" size={30} />
            </div>
        <div style={{display: 'flex', overflowX: 'scroll', width: '100%'}}>
             {[...Array(10)].map((el, idx) => (
                <> 
              <div className="card" style={{backgroundImage: "url('/images/kfc-card.png')"}} />  
            </>
            ))}    
           
        </div>
        </div>
    

    <h2 style={{backgroundColor: '#EEE8F4', padding: 10}}>Local businesses</h2>
    <div className='service-list'>  
     {SERVICES.map((service) => (
        <div className='service-card' key={service.name}>
            <img src={service.img} className='service-img' />
            <div>
            <p>{service.name}</p>
            <p className='service-price'>${service.price}</p>
            </div>
        </div>
     ))}
    </div>
    </div>
    );
}
