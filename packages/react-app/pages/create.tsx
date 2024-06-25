import { useRouter } from 'next/router'
import React from 'react'

export default function create() {
 
  return (
    <>
    <div className='egift-placeholder'>
        <img src="/images/kfc-card.png" />
    </div>
    <h4>Create Gift card on chain</h4>
    <div className='form-wrapper'>
      <form className='create-form'>
        <div className='form-control'>
            <input className='form-input' type="text" />
        </div>

        <div className='form-control'>
            <input className='form-input'  type="text" />
        </div>

        <div className='form-control'>
            <input className='form-input' type="text" />
        </div>

        <div className='form-control'>
            <input className='form-input' type="text" />
        </div>


        <button type="submit" className='btn form-btn'>Create</button>
      </form>
    </div>
    </>
  )
}
