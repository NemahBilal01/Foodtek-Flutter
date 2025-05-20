@extends('layouts.app')

@section('content')
<div class="row">
    <div class="col">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title mb-4 d-inline">Delivery Tracking</h5>
         <a  href="#" class="btn btn-outline-dark mb-4 text-center mx-5 mt-3">Create New</a>
          <table class="table table-striped">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">order_id</th>
                <th scope="col">latitude</th>
                <th scope="col">longitude</th>
                <th scope="col">last_updated_at</th>
                <th scope="col">created_at</th>
                <th scope="col">updated_at</th>
                <th scope="col">action</th>
              </tr>
            </thead>

            <tbody>
              <tr>
              @foreach ($deliveryTracking as $deliveryTrack )
                <th scope="row"> {{ $deliveryTrack->id  }}</th>
                <td> {{ $deliveryTrack->order_id }}</td>
                <td>  {{ $deliveryTrack->latitude }}</td>
                <td> {{  $deliveryTrack->longitude }}</td>
                <td> {{  $deliveryTrack->last_updated_at }}</td>
                <td> {{  $deliveryTrack->created_at }}</td>
                <td> {{  $deliveryTrack->updated_at }}</td>
                <td>
                    <a class="btn btn-primary" href="#" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">Edit</a>
                    <form action="#" method="POST" style="display:inline;">
                        @csrf
                        @method('DELETE')
                        <button  class="btn btn-danger" type="submit"  style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">Delete</button>
                    </form>
                </td>
              </tr>
            @endforeach
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

@endsection
