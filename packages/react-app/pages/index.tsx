import { SERVICES } from "@/data";
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
        <>
        <div className="flex flex-col justify-center items-center" style={{background: '#D9D9D9', padding: 20 }}>
            {isConnected ? (
                <>
                <h1 className="mb-2">Your Wallet</h1>
                <div className="h2 text-center pb-3">
                    balance: ${data?.formatted as any} 
                </div>

                <div className="h2 text-center">
                    address: {userAddress}
                </div>
                </>

            ) : (
                <div>No Wallet Connected</div>
            )}
        </div>
        <div style={{display: 'flex', overflowX: 'scroll', width: '100%'}}>
             {[...Array(10)].map((el, idx) => (
                <> 
              <div className="card" style={{backgroundImage: "url('/images/kfc-card.png')"}} />  
            </>
            ))}    
           
        </div>

        <div className='service-list'>
      
     {SERVICES.map((service) => (
        <div className='card-2' key={service.name}>
            <img src={service.img} className='service-img' />
            <div>
            <p>{service.name}</p>
            <p className='service-price'>${service.price}</p>
            </div>
        </div>
     ))}
    </div>
    </>
    );
}
