import { CreditCard, House, History } from 'lucide-react'
 
  export default function Footer() {
    return (
      <footer>
      <div className='icon-wrapper'>
          <House  />
          <small>Home</small>
      </div>

      <div className='icon-wrapper'>
          <CreditCard />
          <small>Start</small>
      </div>

      <div className='icon-wrapper'>
          <History />
          <small>History</small>
      </div>

  </footer>
    )
  }