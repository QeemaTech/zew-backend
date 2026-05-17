<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileUpdateRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Storage;
use Illuminate\View\View;

class ProfileController extends Controller
{
    /**
     * Display the user's profile form.
     */
    public function edit(): View
    {
        $user = Auth::user();

        $vendor = null;
        $profileImage = $user->image;
        if ($user && $user->hasRole('vendor')) {
            $vendor = $user->vendor();
            if ($vendor?->image) {
                $profileImage = $vendor->image;
            }
        }

        return view('auth.profile', [
            'user' => $user,
            'vendor' => $vendor,
            'profileImage' => $profileImage,
        ]);
    }

    /**
     * Update the user's profile information.
     */
    public function update(ProfileUpdateRequest $request): RedirectResponse
    {
        $data = $request->validated();
        $user = $request->user();

        // Store image on vendor profile if user is vendor owner, otherwise on user profile.
        if ($request->hasFile('image')) {
            if ($user->hasRole('vendor') && $user->vendor()) {
                $vendor = $user->vendor();
                $oldVendorImagePath = $vendor->getRawOriginal('image');
                if ($oldVendorImagePath && Storage::disk('public')->exists($oldVendorImagePath)) {
                    Storage::disk('public')->delete($oldVendorImagePath);
                }
                $vendor->image = $request->file('image')->store('vendors', 'public');
                $vendor->save();
            } else {
                $oldUserImagePath = $user->getRawOriginal('image');
                if ($oldUserImagePath && Storage::disk('public')->exists($oldUserImagePath)) {
                    Storage::disk('public')->delete($oldUserImagePath);
                }
                $data['image'] = $request->file('image')->store('users', 'public');
            }
        }

        $user->fill($data);

        if ($user->isDirty('email')) {
            $user->email_verified_at = null;
        }

        $user->save();

        return Redirect::route('profile')->with('status', 'profile-updated');
    }

    /**
     * Delete the user's account.
     */
    public function destroy(Request $request): RedirectResponse
    {
        $request->validateWithBag('userDeletion', [
            'password' => ['required', 'current_password'],
        ]);

        $user = $request->user();

        Auth::logout();

        $user->delete();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return Redirect::to('/');
    }
}
