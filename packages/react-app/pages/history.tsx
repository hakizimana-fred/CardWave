import React from 'react'

export default function history() {
  return (
    <div>
    {[...Array(6)].map((el, idx) => (
        <>
        <div className='history-wrapper'>
            <div className='wrapper-dets'>
                <img className='history-logo' src='/images/bunny.png' />
                <h4>Name</h4>
            </div>
            <p>$500</p>
        </div>
        </>
    ))}
    </div>
  )
}
