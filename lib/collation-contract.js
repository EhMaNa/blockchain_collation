/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const { Contract } = require('fabric-contract-api');

class CollationContract extends Contract {

    async collationExists(ctx, collationId) {
        const buffer = await ctx.stub.getState(collationId);
        return (!!buffer && buffer.length > 0);
    }

    async createCollation(ctx, collationId, value) {
        const exists = await this.collationExists(ctx, collationId);
        if (exists) {
            throw new Error(`The collation with ${collationId} already exists`);
        }
        const asset = { value };
        const buffer = Buffer.from(JSON.stringify(asset));
        await ctx.stub.putState(collationId, buffer);
    }

    async readCollation(ctx, collationId) {
        const exists = await this.collationExists(ctx, collationId);
        if (!exists) {
            throw new Error(`The collation ${collationId} does not exist`);
        }
        const buffer = await ctx.stub.getState(collationId);
        const asset = JSON.parse(buffer.toString());
        return asset;
    }

    async updateCollation(ctx, collationId, newValue) {
        const exists = await this.collationExists(ctx, collationId);
        if (!exists) {
            throw new Error(`The collation with ${collationId} does not exist`);
        }
        const asset = { value: newValue };
        const buffer = Buffer.from(JSON.stringify(asset));
        await ctx.stub.putState(collationId, buffer);
    }

    async deleteCollation(ctx, collationId) {
        const exists = await this.collationExists(ctx, collationId);
        if (!exists) {
            throw new Error(`The collation ${collationId} does not exist`);
        }
        await ctx.stub.deleteState(collationId);
    }

}

module.exports = CollationContract;
